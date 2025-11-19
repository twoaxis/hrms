using Domain.Entites;
using Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repositories
{
    public class RefreshTokenRepository(ApplicationDbContext dbContext) : IRefreshTokenRepository
    {
        private readonly ApplicationDbContext _dbContext = dbContext;
        public Task CreateRefreshToken(string token, string userId, DateTime expiresAt)
        {
            _dbContext.RefreshTokens.Add(new RefreshToken(token, userId, expiresAt));
            return _dbContext.SaveChangesAsync();
        }
        public Task<RefreshToken?> GetRefreshToken(string token)
        {
            return _dbContext.RefreshTokens.FindAsync(token).AsTask();

        }
        public async Task DeleteRefreshToken(string token)
        {
            var refreshToken = await _dbContext.RefreshTokens.FindAsync(token);
            if (refreshToken != null)
            {
                _dbContext.RefreshTokens.Remove(refreshToken);
                await _dbContext.SaveChangesAsync();
            }
        }
    }
}
