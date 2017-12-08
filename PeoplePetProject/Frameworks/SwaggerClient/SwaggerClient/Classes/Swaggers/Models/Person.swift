//
// Person.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Person: Codable {

    public enum Gender: String, Codable { 
        case male = "Male"
        case female = "Female"
    }
    /** Name of person */
    public var name: String
    /** Gender of person */
    public var gender: Gender
    /** Age of person */
    public var age: Double
    public var pets: [Pet]?


    
    public init(name: String, gender: Gender, age: Double, pets: [Pet]?) {
        self.name = name
        self.gender = gender
        self.age = age
        self.pets = pets
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(name, forKey: "name")
        try container.encode(gender, forKey: "gender")
        try container.encode(age, forKey: "age")
        try container.encodeIfPresent(pets, forKey: "pets")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decode(String.self, forKey: "name")
        gender = try container.decode(Gender.self, forKey: "gender")
        age = try container.decode(Double.self, forKey: "age")
        pets = try container.decodeIfPresent([Pet].self, forKey: "pets")
    }
}
