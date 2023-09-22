package com.denis.portfoliospringporject.components;

import com.denis.portfoliospringporject.dto.UserDTO;
import com.denis.portfoliospringporject.models.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class UserDTOConverter {
    public UserDTO entityToDto(User user){
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setFirstName(user.getFirstName());
        dto.setLastName(user.getLastName());
        dto.setEmail(user.getEmail());
        dto.setUsd(user.getUsd());
        dto.setImage(user.getImage());
        dto.setPassword(user.getPassword());
        dto.setCreatedAt(user.getCreatedAt());
        dto.setLastLogin(user.getLastLogin());
        dto.setTransactions(user.getTransactions());
        dto.setRoles(user.getRoles());

        return dto;
    }

    public List<UserDTO> entityToDtoList(List<User> users) {
        List<UserDTO> dtoList = new ArrayList<>();
        for (User user : users) {
            dtoList.add(entityToDto(user));
        }
        return dtoList;
    }


}
