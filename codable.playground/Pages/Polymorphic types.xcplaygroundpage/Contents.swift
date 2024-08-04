import Foundation

/*
 Resulting JSON should look like this:
 
 [
   {
     "name" : "John Appleseed",
     "id" : 7
   },
   {
     "id" : 7,
     "name" : "John Appleseed",
     "birthday" : 580797832.94787002,
     "toy" : {
       "name" : "Teddy Bear"
     }
   }
 ]

 */

struct Toy: Codable {
    var name: String
}
let toy = Toy(name: "Teddy Bear")
let encoder = JSONEncoder()
let decoder = JSONDecoder()

enum AnyEmployee: Encodable {
    case defaultEmployee(String, Int)
    case customEmployee(String, Int, Date, Toy)
    case noEmployee
    
    enum CodingKeys: CodingKey {
        case name, id, birthday, toy
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .defaultEmployee(let name, let id):
            try container.encode(name, forKey: .name)
            try container.encode(id, forKey: .id)
        case .customEmployee(let name, let id, let birthday, let toy):
            try container.encode(name, forKey: .name)
            try container.encode(id, forKey: .id)
            try container.encode(birthday, forKey: .birthday)
            try container.encode(toy, forKey: .toy)
        case .noEmployee:
            let context = EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Invalid employee!")
            throw EncodingError.invalidValue(self, context)
        }
    }
}

// Decoding is a little bit more complicated, as we have to work out what is in the JSON
// before we can decide how to proceed.
extension AnyEmployee: Decodable {
    init(from decoder: Decoder) throws {
        // Get a keyed container as usual, then inspect the allKeys property to determine which
        // keys are present in the JSON.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let containerKeys = Set(container.allKeys)
        let defaultKeys = Set<CodingKeys>([.name, .id])
        let customKeys = Set<CodingKeys>([.name, .id, .birthday, .toy])
        
        // Check whether the containerKeys matches the keys needed for a default employee or a
        // custom employee and extract the relevant properties; otherwise, make a .noEmployee.
        // You can choose to throw an error if there is no suitable default.
        switch containerKeys {
        case defaultKeys:
            let name = try container.decode(String.self, forKey: .name)
            let id = try container.decode(Int.self, forKey: .id)
            self = .defaultEmployee(name, id)
        case customKeys:
            let name = try container.decode(String.self, forKey: .name)
            let id = try container.decode(Int.self, forKey: .id)
            let birthday = try container.decode(Date.self, forKey: .birthday)
            let toy = try container.decode(Toy.self, forKey: .toy)
            self = .customEmployee(name, id, birthday, toy)
        default:
            self = .noEmployee
        }
    }
}


let employees = [
    AnyEmployee.defaultEmployee("John Appleseed", 7),
    AnyEmployee.customEmployee("John Appleseed", 7, Date(), toy)
]
let employeesData = try encoder.encode(employees)
let employeesString = String(data: employeesData, encoding: .utf8)!
let sameEmployees = try decoder.decode([AnyEmployee].self, from: employeesData)

