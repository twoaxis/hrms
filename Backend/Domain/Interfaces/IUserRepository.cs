using Domain.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Interfaces
{
    public interface IUserRepository
    {
        Task CreateUser(string Id, string name, string email, string passwordHash, string department);
        Task <User?> GetUserByEmail(string email);
        Task<User?> GetUserById(string id);


    }
}
