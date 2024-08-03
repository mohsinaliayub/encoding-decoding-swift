import Foundation

struct Toy: Codable {
    var name: String
}
let toy = Toy(name: "Teddy Bear")
let encoder = JSONEncoder()
let decoder = JSONDecoder()

enum AnyEmployee {
    case defaultEmployee(String, Int)
    case customEmployee(String, Int, Date, Toy)
    case noEmployee
}
