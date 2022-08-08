import Foundation

class WebServices {
    
    static func loadData(completionHandler: @escaping (Event?, Bool?) -> Void) {
        Network.loadJSONFile(named: "WWDCAttendees", type: [Attendee].self) { (attendees, error) in
            guard error == nil else {
                completionHandler(nil, false)
                return
            }
            
            Network.loadJSONFile(named: "WWDCSessions", type: [Session].self) { (sessions, error) in
                guard error == nil else {
                    completionHandler(nil, false)
                    return
                }
                
                let event = Event()
                event.attendees = attendees ?? []
                event.sessions = sessions ?? []
                
                completionHandler(event, true)
            }
        }
    }
}
