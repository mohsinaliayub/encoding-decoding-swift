import Foundation

struct Toy: Codable {
    var name: String
}

struct Employee: Encodable {
    var name: String
    var id: Int
    var favoriteToy: Toy
    
    enum CodingKeys: CodingKey {
        case id, name, gift
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy.name, forKey: .gift)
    }
}

extension Employee: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        let gift = try container.decode(String.self, forKey: .gift)
        favoriteToy = Toy(name: gift)
    }
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee(name: "John Appleseed", id: 7, favoriteToy: toy)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let data = try encoder.encode(employee)
let string = String(data: data, encoding: .utf8)!

let sameEmployee = try decoder.decode(Employee.self, from: data)

