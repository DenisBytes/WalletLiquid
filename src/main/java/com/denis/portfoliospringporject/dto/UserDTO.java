package com.denis.portfoliospringporject.dto;

import com.denis.portfoliospringporject.models.Role;
import com.denis.portfoliospringporject.models.Transaction;
import jakarta.persistence.Column;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class UserDTO {
    private Long id;

    @NotBlank(message = "First Name is required")
    @Size(min=3, max=30, message = "At least 3 characters")
    private String firstName;

    @NotBlank(message = "Last Name is required")
    @Size(min=3, max=30, message = "At least 3 characters")
    private String lastName;

    @Column(unique = true)
    @NotBlank(message = "Email is required")
    @Size(min=5, message = "At least 5 characters")
    @Email(message = "Invalid email format")
    private String email;

    private double usd;

    private String image;

    @NotBlank(message = "Password is required")
    @Size(min=5, message = "At least 5 characters")
    @Pattern(regexp="^(?=.*[A-Z])(?=.*\\d).*$", message="Password must contain at least one capital letter and two numbers")
    private String password;

    private LocalDateTime createdAt;

    private LocalDateTime lastLogin;

    private List<Transaction> transactions;

    private List<Role> roles;
}
