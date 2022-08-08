import Foundation
import CoreLocation
import MapKit

class AccidentLocation: NSObject, Codable {
    let 發生時間,處理別,肇事地點: String
    let latitude: Double
    let longitude: Double

    init(dictionary: [String: Any]) {
        self.發生時間 = dictionary["發生時間"] as? String ?? ""
        self.處理別 = dictionary["處理別"] as? String ?? ""
        self.肇事地點 = dictionary["肇事地點"] as? String ?? ""
        self.latitude = Double(dictionary["latitude"] as? String ?? "") ?? 0
        self.longitude = Double(dictionary["longitude"] as? String ?? "") ?? 0
    }
}

extension AccidentLocation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    var title: String? { 發生時間 }
    var subtitle: String? { 肇事地點 }
}
//extension AccidentLocation: CustomStringConvertible {
//    var description: String {
//        return "AccidentLocation#: " + String(發生時間) + " - 處理別: " + 處理別 + " - 肇事地點: " + 肇事地點 + "(\(latitude) + \(longitude))"
//    }
//}
//extension AccidentLocation: Equatable {
//    static func ==(lhs: AccidentLocation, rhs: AccidentLocation) -> Bool {
//        return lhs.latitude == rhs.latitude &&
//        lhs.longitude == rhs.longitude
//    }
//}
