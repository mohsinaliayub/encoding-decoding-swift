import Foundation

/*
 Resulting JSON representation
 
 {
   "name" : "Teddy Bear",
   "label" : [
     "teddy bear",
     "TEDDY BEAR",
     "Teddy Bear"
   ]
 }

 */


let encoder = JSONEncoder()
let decoder = JSONDecoder()

struct Toy: Encodable {
    var name: String
    var label: String
    
    enum CodingKeys: CodingKey {
        case name, label
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        var labelContainer = container.nestedUnkeyedContainer(forKey: .label)
        
        try labelContainer.encode(name.lowercased())
        try labelContainer.encode(name.uppercased())
        try labelContainer.encode(name)
    }
}

extension Toy: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        var labelContainer = try container.nestedUnkeyedContainer(forKey: .label)
        var labelName = ""
        while !labelContainer.isAtEnd {
            labelName = try labelContainer.decode(String.self)
        }
        label = labelName
    }
}


let toy = Toy(name: "Teddy Bear", label: "Teddy Bear")
let data = try encoder.encode(toy)
let string = String(data: data, encoding: .utf8)!

let sameToy = try decoder.decode(Toy.self, from: data)
