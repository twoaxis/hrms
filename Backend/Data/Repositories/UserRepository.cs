using Domain;
using Domain.Entites;
using Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repositories
{
    public class UserRepository(ApplicationDbContext dbContext) : IUserRepository
    {
       private readonly ApplicationDbContext _dbContext = dbContext;
        public Task CreateUser(string Id, string name, string email, string passwordHash, string department, Role role)
        {
            
            _dbContext.Users.Add(new User(Id ,name, email, department, role, passwordHash));
            return _dbContext.SaveChangesAsync();   
        }

        public Task<User?> GetUserByEmail(string email)
        {

            return _dbContext.Users.FirstOrDefaultAsync(u => u.Email == email);

        }
    }
}
