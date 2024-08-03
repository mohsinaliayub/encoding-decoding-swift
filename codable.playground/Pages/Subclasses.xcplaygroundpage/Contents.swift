import Foundation

/*
 Required JSON.
 
 
 {
   "toy" : {
     "name" : "Teddy Bear"
   },
   "employee" : {
     "name" : "John Appleseed",
     "id" : 7
   },
   "birthday" : 580794178.33482599
 }

 */

struct Toy: Codable {
    var name: String
}

class BasicEmployee: Codable {
    var name: String
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

class GiftEmployee: BasicEmployee {
    var birthday: Date
    var toy: Toy
    
    init(name: String, id: Int, birthday: Date, toy: Toy) {
        self.birthday = birthday
        self.toy = toy
        super.init(name: name, id: id)
    }
    
    enum CodingKeys: CodingKey {
        case employee, birthday, toy
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        birthday = try container.decode(Date.self, forKey: .birthday)
        toy = try container.decode(Toy.self, forKey: .toy)
        
        let baseDecoder = try container.superDecoder(forKey: .employee)
        try super.init(from: baseDecoder)
    }
    
    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(toy, forKey: .toy)
        let baseEncoder = container.superEncoder(forKey: .employee)
        try super.encode(to: baseEncoder)
    }
}

let toy = Toy(name: "Teddy Bear")
let encoder = JSONEncoder()
let decoder = JSONDecoder()

let giftEmployee = GiftEmployee(name: "John Appleseed", id: 7, birthday: Date(), toy: toy)
let giftData = try encoder.encode(giftEmployee)
let giftString = String(data: giftData, encoding: .utf8)
let sameGiftEmployee = try decoder.decode(GiftEmployee.self, from: giftData)


