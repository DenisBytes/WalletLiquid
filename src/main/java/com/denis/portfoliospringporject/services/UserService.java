package com.denis.portfoliospringporject.services;

import com.denis.portfoliospringporject.models.LoginUser;
import com.denis.portfoliospringporject.models.User;
import com.denis.portfoliospringporject.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepo;

    public User register(User newUser, BindingResult result){

        Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());

        if(potentialUser.isPresent()){
            result.rejectValue("email","EmailTaken",
                    "the email has already been taken");
        }
        if(!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches",
                    "The Confirm Password must match Password!");
        }
        if(result.hasErrors()){
            return null;
        }
        else{
            String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
            newUser.setPassword(hashed);
            return userRepo.save(newUser);
        }
    }

    public User login(LoginUser newLoginObject, BindingResult result){

        Optional<User> potentialUser = userRepo.findByEmail(newLoginObject.getEmail());

        if(!potentialUser.isPresent()){
            result.rejectValue("email","EmailNotFound","the email does not exist");
        }else{
            if(!BCrypt.checkpw(newLoginObject.getPassword(), potentialUser.get().getPassword())) {
                result.rejectValue("password", "Matches", "Invalid Password!");
            }
        }
        if(result.hasErrors()){
            return null;
        }else{
            return potentialUser.get();
        }
    }

    public void updateUser(User user) {
        userRepo.save(user);
    }

    public User findByEmail(String email) {
        return userRepo.findByEmail(email).orElse(null);
    }

    public List<User> allUsers(){
        return userRepo.findAll();
    }


    public void deleteUser(User user) {
        userRepo.delete(user);
    }

    public User findById(Long id) {
        return userRepo.findById(id).orElse(null);
    }

    public List<User> allUserByMostUsd(){
        return userRepo.findAllByOrderByUsdDesc();
    }

}