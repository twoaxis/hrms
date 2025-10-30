using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entites
{
    public class RefreshToken
    {
        public string Token { get; set; } = null!;
        public string UserId { get; set; } = null!; 

        public DateTime ExpiresAt = DateTime.UtcNow.AddDays(7);
        public User User { get; set; } = null!;
        public RefreshToken() { }
        public RefreshToken(string token, string userId ,DateTime expiresAt)
        {
            Token = token;
            UserId = userId;
            ExpiresAt = expiresAt;
        }
    }
}
