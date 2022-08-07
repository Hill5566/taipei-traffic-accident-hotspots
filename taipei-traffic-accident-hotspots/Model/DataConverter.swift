//
//  CsvToJson.swift
//  taipei-traffic-accident-hotspots
//
//  Created by Lin Hill on 2022/8/5.
//

import Foundation

struct DataConverter {
    static func csvToArrray(fileName:String, withExtension:String) -> [[String:String]] {

        let file = Bundle.main.url(forResource: fileName, withExtension: withExtension)
        let data = try? String(contentsOf: file!)
        
        var result: [[String:String]] = []
        
        var rows = data!.components(separatedBy: "\n")
        let keysRow = rows.first!
        rows.removeFirst()
        let keys = keysRow.replacingOccurrences(of: "\r", with: "").components(separatedBy: ",")
        
        for row in rows {
            let columns = row.replacingOccurrences(of: "\r", with: "").components(separatedBy: ",")
            let dict = Dictionary(uniqueKeysWithValues: zip(keys, columns))
            result.append(dict)
        }
        return result
    }
    
}
