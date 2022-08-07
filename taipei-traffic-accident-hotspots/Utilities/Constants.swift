import Foundation

struct Constants {
    struct DateFormatters {
        static let simpleDateFormatter: DateFormatter = {
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter
        }()
    }
}
