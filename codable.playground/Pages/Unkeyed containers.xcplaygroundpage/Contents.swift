import Foundation

/*
 Resulting JSON should look like this.
 
 [
   "teddy bear",
   "TEDDY BEAR",
   "Teddy Bear"
 ]

 */

struct Toy: Codable {
    var name: String
}

let toy = Toy(name: "Teddy Bear")

let encoder = JSONEncoder()
let decoder = JSONDecoder()

struct Label: Encodable {
    var toy: Toy
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(toy.name.lowercased())
        try container.encode(toy.name.uppercased())
        try container.encode(toy.name)
    }
}

extension Label: Decodable {
    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var name = ""
        while !container.isAtEnd {
            name = try container.decode(String.self)
        }
        toy = Toy(name: name)
    }
}

let label = Label(toy: toy)
let labelData = try encoder.encode(label)
let labelString = String(data: labelData, encoding: .utf8)!
let sameLabel = try decoder.decode(Label.self, from: labelData)
