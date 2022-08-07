import Foundation
import CoreLocation

struct AccidentLocation: Decodable {
    let 發生時間,處理別,肇事地點: String
    let latitude: Double
    let longitude: Double
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
//    init(dictionary: [String: Any]) {
//        self = try! JSONDecoder().decode(AccidentLocation.self, from: JSONSerialization.data(withJSONObject: dictionary))
//    }
    init(dictionary: [String: Any]) {
        self.發生時間 = dictionary["發生時間"] as? String ?? ""
        self.處理別 = dictionary["處理別"] as? String ?? ""
        self.肇事地點 = dictionary["肇事地點"] as? String ?? ""
        self.latitude = Double(dictionary["latitude"] as? String ?? "") ?? 0
        self.longitude = Double(dictionary["longitude"] as? String ?? "") ?? 0
    }
}
extension AccidentLocation: CustomStringConvertible {
    var description: String {
        return "AccidentLocation#: " + String(發生時間) + " - 處理別: " + 處理別 + " - 肇事地點: " + 肇事地點 + "(\(latitude) + \(longitude))"
    }
}
extension AccidentLocation: Equatable {
    static func ==(lhs: AccidentLocation, rhs: AccidentLocation) -> Bool {
        return lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
