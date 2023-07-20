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
        if(result.hasErrors()){
            model.addAttribute("newLogin", new LoginUser());
            return "loginPage";
        }
        userService.register(user,result);

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


    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.setAttribute("loggedInUserID", null);
        return "redirect:/index";
    }

}