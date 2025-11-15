using Domain;
using Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;

namespace Infrastructure
{
    public class JwtProvider(string secret) : IJwtProvider
    {
       private readonly string _secret = secret;


        public string GenerateToken(string userId, string name, string email, string department, Role userRole)
        {

            var claims = new List<Claim>
            {
                new(JwtRegisteredClaimNames.Sub, userId),
                new(JwtRegisteredClaimNames.Name, name),
                new(JwtRegisteredClaimNames.Email, email),
                new("department", department),
                new("role", userRole.ToString())

            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_secret));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: "hrms.twoaxis.org",
			    audience: "hrms.twoaxis.org",
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
