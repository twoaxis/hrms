using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Interfaces
{
    public interface IJwtProvider
    {
        string GenerateToken(string userId,string name,string email ,string department ,Role userRole);
    }
}
