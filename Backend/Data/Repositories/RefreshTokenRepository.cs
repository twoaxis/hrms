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
    }
}
