import Foundation

struct Toy: Codable {
    var name: String
}

let toy = Toy(name: "Teddy Bear")

let encoder = JSONEncoder()
let decoder = JSONDecoder()

struct Label: Encodable {
    var toy: Toy
}

let label = Label(toy: toy)
let labelData = try encoder.encode(label)
let labelString = String(data: labelData, encoding: .utf8)!
