import Foundation

struct User: CardModelType {
  let userId: String
  let name: String
  var age: Int?
  var profession: String?
  let userImages: [String]
}

extension User {
  init(dictionary: [String: Any]) {
    self.userId = dictionary["uid"] as? String ?? ""
    self.name = dictionary["fullName"] as? String ?? ""
    self.age = dictionary["age"] as? Int
    self.profession = dictionary["profession"] as? String
    self.userImages = dictionary["images"] as? [String] ?? []
  }
}




