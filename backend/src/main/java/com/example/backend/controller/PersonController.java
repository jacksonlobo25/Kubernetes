package com.example.backend.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.backend.model.Person;
import com.example.backend.service.PersonService;

@Controller
public class PersonController {

    @Autowired
    private PersonService personService;

    @GetMapping
    public String viewHomePage(Model model) {
        java.util.List<Person> persons = personService.getAllUsers();
        model.addAttribute("persons", persons);
        return "list";
    }

    @GetMapping("/new")
    public String showNewUserForm(Model model) {
        Person person = new Person();
        model.addAttribute("person", person);
        return "form";
    }

    @PostMapping("/save")
    public String saveUser(@ModelAttribute("person") Person person) {
        personService.saveUser(person);
        return "redirect:/";
    }

    @GetMapping("/edit/{id}")
    public String showFormForUpdate(@PathVariable("id") String id, Model model) {
    	Person person = personService.getUserById(UUID.fromString(id));
        model.addAttribute("person", person);
        return "form";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") String id) {
        personService.deleteUserById(UUID.fromString(id));
        return "redirect:/";
    }
}