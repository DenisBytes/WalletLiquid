package com.denis.portfoliospringporject.controllers;

import com.denis.portfoliospringporject.models.LoginUser;
import com.denis.portfoliospringporject.models.User;
import com.denis.portfoliospringporject.services.UserService;
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
import java.util.Date;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    //REGISTERING THE USER
    @PostMapping("/register")
    public String registerIndex(@Valid @ModelAttribute("newUser")User user,
                                BindingResult result, Model model, HttpSession session){
        user.setImage("images/profile.jpg");
        user.setUsd(100000);
        userService.register(user,result);

        if(result.hasErrors()){
            model.addAttribute("newLogin", new LoginUser());
            return "loginPage";
        }
        session.setAttribute("loggedInUserID", user.getId());

        return "redirect:/trade";
    }

    //LOGGING IN THE USER
    @PostMapping("/login")
    public String loginIndex(@Valid @ModelAttribute("newLogin") LoginUser loginUser,
                             BindingResult result, Model model, HttpSession session){
        User user = userService.login(loginUser,result);

        if(result.hasErrors()){
            model.addAttribute("newUser",new User());
            return "loginPage";
        }

        session.setAttribute("loggedInUserID", user.getId());

        return "redirect:/trade";
    }

    // We will call this method to automatically log in newly registered users

    @RequestMapping("/admin/{id}")
    public String makeAdmin(Principal principal, @PathVariable("id") Long id, Model model) {
        if(principal==null) {
            return "redirect:/login";
        }

        User user = userService.findById(id);

        model.addAttribute("users", userService.allUsers());

        return "adminPage";
    }

    @GetMapping("/login")
    public String login(
            @ModelAttribute("newUser") User user,
            @ModelAttribute("newLogin") LoginUser loginUser,
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

    @RequestMapping(value={"/", "/home"})
    public String home(Principal principal, Model model) {
        if(principal==null) {
            return "redirect:/login";
        }
        String email = principal.getName();
        User user = userService.findByEmail(email);
        model.addAttribute("user", user);

        if(user!=null) {
            user.setLastLogin(new Date());
            userService.updateUser(user);
            // If the user is an ADMIN or SUPER_ADMIN they will be redirected to the admin page
            if (user != null && user.getRoles() != null && !user.getRoles().isEmpty()) {
                if (user.getRoles().get(0).getName().contains("ROLE_SUPER_ADMIN") || user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
                    // Role check logic here
                }
                model.addAttribute("currentUser", userService.findByEmail(email));
                model.addAttribute("users", userService.allUsers());
                return "adminPage";
            }


        }
        // All other users are redirected to the home page

        return "trade";
    }

    @RequestMapping("/delete/{id}")
    public String deleteUser(Principal principal, @PathVariable("id") Long id, HttpSession session, Model model) {
        if(principal==null) {
            return "redirect:/login";
        }
        User user = userService.findById(id);
        userService.deleteUser(user);

        session.invalidate();
        model.addAttribute("users", userService.allUsers());

        return "redirect:/index";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.setAttribute("loggedInUserID", null);
        return "redirect:/index";
    }
}