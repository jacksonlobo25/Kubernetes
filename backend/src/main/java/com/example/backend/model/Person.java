package com.example.backend.model;

import java.util.UUID;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "persons")
public class Person {
    
    @Id
    private UUID  id;
    
    private String name;
    private String email;
	private String role;
    
	public Person() {
        this.id = UUID.randomUUID(); // Generate a new UUID for the ID field
    }
    
    public Person(String name, String email,String role) {
    	this.id = UUID.randomUUID();
        this.name = name;
        this.email = email;
		this.role = role;
    }

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}