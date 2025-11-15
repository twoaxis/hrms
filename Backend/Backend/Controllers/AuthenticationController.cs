using Application.DTOS;
using Application.Services;
using Domain.Exceptions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController(AuthenticationService authenticationService) : ControllerBase
    {
        private readonly AuthenticationService _authenticationService = authenticationService;
        [HttpPost("signup")]
        public async Task<IActionResult> SignUp([FromBody] SignupRequestDTO request)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var response = await _authenticationService.SignUp(request.Name, request.Email, request.Password, request.Department);
                return Ok(response);
            }
            catch (UserExistsException)
            {
                return Conflict(new { message = "User with this email already exists." });
            }

            
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequestDTO request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            try
            {
                var response = await _authenticationService.Login(request.Email, request.Password);
                return Ok(response);
            }
            catch (InvalidCredentialsException)
            {
                return Unauthorized(new { message = "Invalid email or password." });
            }
        }

    }
}
