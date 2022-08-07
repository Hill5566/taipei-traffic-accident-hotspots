import Foundation

//
// MARK: - Event
//
class Event {
  //
  // MARK: - Variables And Properties
  //
  var attendees: [Attendee] = []
  var sessions: [Session] = []
  
  //
  // MARK: - Instance Methods
  //
  func attendees(for session: Session) -> [Attendee] {
    return attendees.filter { (attendee) -> Bool in
      session.attendeesBadges.contains(attendee.badgeNumber)
    }
  }
  
  func sessions(for attendee: Attendee) -> [Session] {
    return sessions.filter { (session) -> Bool in
      session.attendeesBadges.contains(attendee.badgeNumber)
    }
  }
}
