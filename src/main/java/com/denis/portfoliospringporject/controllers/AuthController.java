package com.denis.portfoliospringporject.controllers;

import com.denis.portfoliospringporject.components.UserDTOConverter;
import com.denis.portfoliospringporject.models.User;
import com.denis.portfoliospringporject.services.UserService;
import com.denis.portfoliospringporject.validator.UserValidator;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    UserDTOConverter userDTOConverter;

    //REGISTERING THE USER
    @PostMapping("/register")
    public String registerPost(@Valid @ModelAttribute("newUser")User user,
                                BindingResult result, HttpServletRequest request){

        userValidator.validate(user,result);

        if(result.hasErrors()){
            return "loginPage";
        }
        String password= user.getPassword();

        if (userService.isEmailAlreadyRegistered(user.getEmail())) {
            return "redirect:/login";
        }

        if (user.getEmail().equals("axskenda@gmail.com")){
            userService.saveUserWithSuperAdminRole(user);
        }
        else{
            userService.saveWithUserRole(user);
        }

        authWithHttpServletRequest(request, user.getEmail(), password);
        return "redirect:/trade";
    }

    // We will call this method to automatically log in newly registered users
    public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
        try {
            request.login(email, password);
        } catch (ServletException e) {
            System.out.println("Error while login: " + e);
        }
    }


    @GetMapping("/login")
    public String loginGet(@ModelAttribute("newUser") User user,
                        @RequestParam(value="error", required=false) String error,
                        @RequestParam(value="logout", required=false) String logout,
                        Model model) {
        if(error!=null) {
            model.addAttribute("errorMessage","Invalid Credentials, Please try again.");
        }
        if(logout!=null) {
            model.addAttribute("logoutMessage","Logout Successful!");
        }


        return "loginPage";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.setAttribute("loggedInUserID", null);
        return "redirect:/index";
    }

    @GetMapping("/edit/profile")
    public String editProfileGet(Principal principal, Model model){
        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

        model.addAttribute("user", user);

        return "editProfile";
    }

    @PutMapping("/edit/profile")
    public String editProfilePost(@Valid @ModelAttribute ("user")User user,
                                  BindingResult result){
        if (result.hasErrors()){
            return "editProfile";
        }
        user.updateOn();
        userService.updateUser(user);

        return "redirect:/trade";
    }

    @GetMapping("/admin")
    public String adminGet(Principal principal, Model model){
        if (principal == null){
            return "redirect:/login";
        }
        String email = principal.getName();
        User currentuUser = userService.findByEmail(email);


        model.addAttribute("currentUser", userDTOConverter.entityToDto(currentuUser));
        model.addAttribute("usersList", userDTOConverter.entityToDtoList(userService.allUsers()));

        return "adminPage";
    }

    @GetMapping("/admin/{userId}")
    public String adminPut(Principal principal, @PathVariable ("userId") Long userId){

        if (principal == null){
            return "redirect:/login";
        }

        User user = userService.findById(userId);
        userService.upgradeUser(user);

        return "redirect:/admin";
    }

    @GetMapping("/delete/{userId}")
    public String deleteUser(Principal principal, @PathVariable ("userId") Long userId){
        if (principal == null){
            return "redirect:/login";
        }

        userService.deleteUser(userService.findById(userId));

        return "redirect:/admin";
    }

}