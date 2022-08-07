//
//  AccidentListViewModel.swift
//  taipei-traffic-accident-hotspots
//
//  Created by Lin Hill on 2022/8/7.
//

import Foundation

class AccidentListViewModel {
    
    let locations: Box<[AccidentLocation]> = Box([])
    
    init() {
        let locations101year = DataConverter.csvToArrray(fileName: "101", withExtension: "txt")
        var locationsTmp:[AccidentLocation] = []
        locations101year.forEach { location in
            locationsTmp.append(AccidentLocation(dictionary: location))
        }
        locations.value = locationsTmp
        print(locations)
        
    }
    
}
