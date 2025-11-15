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
    public class AuthenticationService(IUserRepository userRepository, IJwtProvider jwtProvider ,IRefreshTokenRepository refreshTokenRepository)
    {
        private readonly IUserRepository _userRepository = userRepository;
        private readonly IJwtProvider _jwtProvider = jwtProvider;
        private readonly IRefreshTokenRepository _refreshTokenRepository = refreshTokenRepository;

        public async Task<AuthResponseDTO>SignUp(string name, string email, string password, string department)
        {
            var existingUser = await _userRepository.GetUserByEmail(email);
            if (existingUser != null)
            {
                throw new UserExistsException();
            }
            var userId = Guid.NewGuid().ToString();
            var passwordHash = BCrypt.Net.BCrypt.HashPassword(password);
            var refreshToken = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));

            await _userRepository.CreateUser(userId, name, email, passwordHash, department);
            await _refreshTokenRepository.CreateRefreshToken(refreshToken, userId, DateTime.UtcNow.AddDays(7));

            var token = _jwtProvider.GenerateToken(userId, name, email,department);
            return new AuthResponseDTO { 

                AccessToken = token,
                RefreshToken = refreshToken
            };
        }

        public async Task<AuthResponseDTO> Login(string email, string password)
        {
            var user = await _userRepository.GetUserByEmail(email);
            if(user == null || !BCrypt.Net.BCrypt.Verify(password, user.PasswordHash))
            {
                throw new InvalidCredentialsException();
            }

            var refreshToken = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
            await  _refreshTokenRepository.CreateRefreshToken( refreshToken, user.Id, DateTime.UtcNow.AddDays(7));

            var token = _jwtProvider.GenerateToken(user.Id, user.Name, user.Email, user.Department);
            return new AuthResponseDTO { 

                AccessToken = token,
                RefreshToken = refreshToken
            };

        }
    }
}
