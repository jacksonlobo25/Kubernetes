package com.example.backend.respository;

import java.util.UUID;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.backend.model.Person;

public interface PersonRepository extends MongoRepository<Person, UUID> {
}