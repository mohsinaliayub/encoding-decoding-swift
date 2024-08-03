import Foundation

struct Toy: Codable {
    var name: String
}

struct Employee: Encodable {
    var name: String
    var id: Int
    var favoriteToy: Toy
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee(name: "John Appleseed", id: 7, favoriteToy: toy)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let nestedData = try encoder.encode(employee)
let nestedString = String(data: nestedData, encoding: .utf8)!

