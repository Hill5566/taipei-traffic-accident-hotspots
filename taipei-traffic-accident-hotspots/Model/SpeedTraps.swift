import Foundation
import CoreLocation
import MapKit

//CityName,RegionName,Address,DeptNm,BranchNm,Longitude,Latitude,direct,limit
//設置縣市,設置市區鄉鎮,設置地址,管轄警局,管轄分局,經度,緯度,拍攝方向,速限

class SpeedTraps: NSObject, Codable {
    let 設置縣市, 設置市區鄉鎮, 設置地址, 管轄警局, 管轄分局, 拍攝方向: String
    let 速限: String
    let latitude: Double
    let longitude: Double

    init(dictionary: [String: Any]) {
        self.設置縣市 = dictionary["設置縣市"] as? String ?? ""
        self.設置市區鄉鎮 = dictionary["設置市區鄉鎮"] as? String ?? ""
        self.設置地址 = dictionary["設置地址"] as? String ?? ""
        self.管轄警局 = dictionary["管轄警局"] as? String ?? ""
        self.管轄分局 = dictionary["管轄分局"] as? String ?? ""
        self.拍攝方向 = dictionary["拍攝方向"] as? String ?? ""
        self.速限 = dictionary["速限"] as? String ?? ""
        self.latitude = Double(dictionary["latitude"] as? String ?? "") ?? 0
        self.longitude = Double(dictionary["longitude"] as? String ?? "") ?? 0
    }
}

extension SpeedTraps: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    var title: String? { 速限 }
    var subtitle: String? { 拍攝方向 }
}
