import Foundation

struct Toy: Codable {
    var name: String
}

class BasicEmployee {
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
    
}

let toy = Toy(name: "Teddy Bear")
let encoder = JSONEncoder()
let decoder = JSONDecoder()


