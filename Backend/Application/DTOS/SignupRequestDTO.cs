using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Application.DTOS
{
    public class SignupRequestDTO
    {
        [Required]
        [JsonPropertyName("name")]
        public string Name { get; set; }
        [Required]
        [JsonPropertyName("email")]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        [JsonPropertyName("password")]
        [MinLength(8)]
        public string Password { get; set; }
        [Required]
        [JsonPropertyName("department")]
        public string Department { get; set; }
    }
}
