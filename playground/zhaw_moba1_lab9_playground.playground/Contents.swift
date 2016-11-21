//: Playground - noun: a place where people can play

import UIKit

var integer: Int = 12;

print("Hi I'm an int my name is: \(integer)\n")

class Address {
    var name: String
    var street: String
    var POB: Int?
    let country: String
    
    convenience init(country: String) {
        self.init(name: "", street: "", country: country)
    }
    
    required init(name: String, street: String, country: String) {
        self.country = country
        self.name = name
        self.street = street
    }
}

var addr0 = Address(name: "Address 0", street: "street 0", country: "CH")
var addr1 = Address(name: "Address 1", street: "street 1", country: "GER")

print("Address 0: \(addr0.name)")