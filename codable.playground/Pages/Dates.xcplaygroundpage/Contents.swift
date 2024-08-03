import Foundation

/*
 Required JSON.
 {
   "id" : 7,
   "name" : "John Appleseed",
   "birthday" : "29-05-2019",
   "toy" : {
     "name" : "Teddy Bear"
   }
 }
 */

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
}

struct Toy: Codable {
    var name: String
}

let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .formatted(.dateFormatter)
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(.dateFormatter)

struct Employee: Codable {
    var name: String
    var id: Int
    var birthday: Date
    var toy: Toy
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee(name: "John Appleseed", id: 7, birthday: Date(), toy: toy)

let dateData = try encoder.encode(employee)
let dateString = String(data: dateData, encoding: .utf8)!
let sameEmployee = try decoder.decode(Employee.self, from: dateData)

