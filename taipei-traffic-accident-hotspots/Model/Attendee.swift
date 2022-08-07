import Foundation

class Attendee: CustomStringConvertible, Decodable {

  var age: UInt8
  var badgeNumber: UInt8
  var isFirstTimeAttending: Bool
  var name: String
  var nationality: String
  
  var description: String {
    return """
    Name: \(name)
    Nationality: \(nationality)
    Age: \(age)
    Badge Number: \(badgeNumber)
    Attending For The First Time: \(isFirstTimeAttending ? "Yes" : "No")
    """
  }
  
  init(age: UInt8, badgeNumber: UInt8, isFirstTimeAttending: Bool, name: String, nationality: String) {
    self.age = age
    self.badgeNumber = badgeNumber
    self.isFirstTimeAttending = isFirstTimeAttending
    self.name = name
    self.nationality = nationality
  }
}
