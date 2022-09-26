import Foundation
import CoreLocation

class AccidentListViewModel {
    
    var userLocation: CLLocation? = nil

    var lockAtUserLocation: Box<Bool> = Box(true)
    
    let locations: Box<[AccidentLocation]> = Box([])
    
    init() {
        let locationsData = DataConverter.csvToArrray(fileName: "101", withExtension: "txt")
        var locationsArray:[AccidentLocation] = []
        locationsData.forEach { location in
            locationsArray.append(AccidentLocation(dictionary: location))
        }
        locations.value = locationsArray
//        print(locations.value)
    }
}
