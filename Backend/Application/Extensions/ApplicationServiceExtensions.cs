using Application.Services;
using Microsoft.Extensions.DependencyInjection;


namespace Application.Extensions
{
    public static class ApplicationServiceExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<AuthenticationService>();

            return services;
        }

    }
}
