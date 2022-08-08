import Foundation

class AccidentListViewModel {
    
    let locations: Box<[AccidentLocation]> = Box([])
    
    init() {
        let locationsData = DataConverter.csvToArrray(fileName: "101", withExtension: "txt")
        var locationsArray:[AccidentLocation] = []
        locationsData.forEach { location in
            locationsArray.append(AccidentLocation(dictionary: location))
        }
        locations.value = locationsArray
        print(locations)
    }
}
