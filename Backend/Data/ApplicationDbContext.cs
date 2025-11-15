using Domain;
using Domain.Entites;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {

        }

        public DbSet<User> Users { get; set; } 
        public DbSet<RefreshToken> RefreshTokens { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(option => {

                option.HasKey(u => u.Id);
                option.Property(u => u.Id).IsRequired();
                option.HasIndex(u => u.Email).IsUnique();
                option.Property(u => u.Name).IsRequired().HasMaxLength(80);
                option.Property(u => u.Email).IsRequired().HasMaxLength(120);
                option.Property(u => u.Department).IsRequired();
                option.Property(u => u.PasswordHash).IsRequired();
               

            });

            modelBuilder.Entity<RefreshToken>(option =>{

                option.HasKey(rt => rt.Token);
                option.Property(rt => rt.Token).IsRequired();
                option.Property(rt => rt.UserId).IsRequired();
                option.Property(rt => rt.ExpiresAt).IsRequired();
                option.HasOne(rt => rt.User)
                      .WithMany()
                      .HasForeignKey(rt => rt.UserId);
                      

            });
               

        }
    }
}
