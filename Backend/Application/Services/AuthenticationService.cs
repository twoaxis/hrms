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

        public async Task<AuthResponseDTO> Login(string email, string password)
        {
            var user = await _userRepository.GetUserByEmail(email);
            if(user == null || !BCrypt.Net.BCrypt.Verify(password, user.PasswordHash))
            {
                throw new InvalidCredentialsException();
            }

            var refreshToken = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
            await  _refreshTokenRepository.CreateRefreshToken( refreshToken, user.Id, DateTime.UtcNow.AddDays(7));

            var accesstoken = _jwtProvider.GenerateToken(user.Id, user.Name, user.Email, user.Department);
            return new AuthResponseDTO { 

                AccessToken = accesstoken,
                RefreshToken = refreshToken
            };

        }

        public async Task<AuthResponseDTO> RefreshToken(string refreshToken)
        {
            var existingToken = await _refreshTokenRepository.GetRefreshToken(refreshToken);
            if (existingToken == null)
            {
                throw new InvalidRefreshTokenException();
            }

            if (existingToken.ExpiresAt < DateTime.UtcNow)
            {
                await _refreshTokenRepository.DeleteRefreshToken(refreshToken);
                throw new InvalidRefreshTokenException();
            }

            var user = await _userRepository.GetUserById(existingToken.UserId);
            if (user == null)
            {
                await _refreshTokenRepository.DeleteRefreshToken(refreshToken);
                throw new InvalidRefreshTokenException();
            }

            var newRefreshToken = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
            await _refreshTokenRepository.CreateRefreshToken(newRefreshToken, user.Id, DateTime.UtcNow.AddDays(7));
            var accesstoken = _jwtProvider.GenerateToken(user.Id, user.Name, user.Email, user.Department);

            return new AuthResponseDTO
            {
                AccessToken = accesstoken,
                RefreshToken = newRefreshToken
            };
        }
    }
}
