using Application.DTOS;
using Domain.Exceptions;
using Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using Domain;

namespace Application.Services
{
    public class AuthenticationService(IUserRepository userRepository, IJwtProvider jwtProvider)
    {
        private readonly IUserRepository _userRepository = userRepository;
        private readonly IJwtProvider _jwtProvider = jwtProvider;

        public async Task<AuthResponseDTO>SignUp(string name, string email, string password, string department)
        {
            var existingUser = await _userRepository.GetUserByEmail(email);
            if (existingUser != null)
            {
                throw new UserExistsException();
            }
            var userId = Guid.NewGuid().ToString();
            var passwordHash = BCrypt.Net.BCrypt.HashPassword(password);

            await _userRepository.CreateUser(userId, name, email, passwordHash, department, Role.Admin);
            var token = _jwtProvider.GenerateToken(userId, name, email,department, Role.Admin);
            return new AuthResponseDTO { AccessToken = token };
        }
    }
}
