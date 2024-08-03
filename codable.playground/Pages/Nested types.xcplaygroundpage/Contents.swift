import Foundation

struct Toy {
    var name: String
}

struct Employee {
    var name: String
    var id: Int
    var favoriteToy: Toy
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee(name: "John Appleseed", id: 7, favoriteToy: toy)

