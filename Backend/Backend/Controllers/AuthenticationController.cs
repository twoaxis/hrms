using Application.DTOS;
using Application.Services;
using Domain.Exceptions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("auth")]
    [ApiController]
    public class AuthenticationController(AuthenticationService authenticationService) : ControllerBase
    {
        private readonly AuthenticationService _authenticationService = authenticationService;

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
                return Unauthorized();
            }
        }

        [HttpPost("refresh")]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequestDTO request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            try
            {
                var response = await _authenticationService.RefreshToken(request.RefreshToken);
                return Ok(response);
            }
            catch (InvalidRefreshTokenException)
            {
                return Unauthorized();
            }
        }

    }
}
