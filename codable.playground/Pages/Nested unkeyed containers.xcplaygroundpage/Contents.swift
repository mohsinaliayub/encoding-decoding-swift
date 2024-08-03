import Foundation

let encoder = JSONEncoder()
let decoder = JSONDecoder()

struct Toy: Encodable {
    var name: String
    var label: String
    
    enum CodingKeys: CodingKey {
        case name, label
    }
}

let toy = Toy(name: "Teddy Bear", label: "Teddy Bear")
let data = try encoder.encode(toy)
let string = String(data: data, encoding: .utf8)!
