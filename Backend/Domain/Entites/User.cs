using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entites
{
    public class User
    {
        [Key]
        [Required]
        public string Id { get; private set; }= null!;

        [Required]
        [MaxLength(80)]
        public string Name { get;private set; } = null!;

        [Required]
        [MaxLength(120)]
        [EmailAddress]
        public string Email { get;private set; } = null!;

        [Required]
        public string Department { get;private set; } = null!;
        [Required]
        public Role Role { get;set; } 
        [Required]
        public string PasswordHash { get;private set; } = null!;
        public User(string id ,string name, string email, string department, Role role, string passwordHash)
        {
            Id = id;
            Name = name;
            Email = email;
            Department = department;
            Role = role;
            PasswordHash = passwordHash;
        }
    }
}
