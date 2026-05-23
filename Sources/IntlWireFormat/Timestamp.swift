import Foundation

/// Wire timestamp formats used by Intellect (Intl) APIs.
public enum Timestamp {
    /// Events and queries: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX` in UTC.
    public static let utc = makeFormatter(
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )
    
    /// Events and queries in the device local time zone.
    public static let local = makeFormatter(
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
        timeZone: TimeZone.current
    )
    
    /// Archive playback: `yyyyMMdd'T'HHmmss.SSSXXX` in UTC.
    public static let archiveUTC = makeFormatter(
        format: "yyyyMMdd'T'HHmmss.SSSXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )
    
    static func makeFormatter(format: String, timeZone: TimeZone) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter
    }
}

