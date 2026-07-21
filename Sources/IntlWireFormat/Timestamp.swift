import Foundation

/// Wire timestamp formats used by Intellect (Intl) APIs.
public enum Timestamp {
    /// ISO8601 for event `ts` and for parsing strings that include an offset.
    public static let event = makeFormatter(
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )

    /// ISO8601 in UTC (legacy name — prefer ``event`` for parsing, ``formatEventQuery(_:)`` for queries).
    public static let utc = event

    /// ISO8601 in the device local time zone — used to format `from`/`to` on `secure/events`.
    public static let local = makeFormatter(
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
        timeZone: TimeZone.current
    )

    /// Archive playback: `yyyyMMdd'T'HHmmss.SSSXXX` in UTC.
    public static let archiveUTC = makeFormatter(
        format: "yyyyMMdd'T'HHmmss.SSSXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )

    /// Parses event `ts` from JSON (`2024-06-04T13:14:03.000+03:00`). Offset in the string is authoritative.
    public static func parseEvent(_ raw: String) -> Date? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        if let date = event.date(from: trimmed) { return date }
        return eventNoFraction.date(from: trimmed)
    }

    /// Parses Intl RTSP archive `Timestamps` track payloads.
    ///
    /// Accepts ``archiveUTC`` wire form and common variants without fractional
    /// seconds and/or with a bare trailing `Z` (e.g. `20250909T112216Z`).
    public static func parseArchiveUTC(_ raw: String) -> Date? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        if let date = archiveUTC.date(from: trimmed) { return date }
        if let date = archiveUTCNoFraction.date(from: trimmed) { return date }

        // Intl often emit `yyyyMMdd'T'HHmmss[.SSS]Z` without a colon offset.
        let withoutZ: String
        if trimmed.hasSuffix("Z") || trimmed.hasSuffix("z") {
            withoutZ = String(trimmed.dropLast())
        } else {
            withoutZ = trimmed
        }
        if withoutZ.contains(".") {
            let parts = withoutZ.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
            guard parts.count == 2,
                  let base = archiveUTCPlain.date(from: String(parts[0])) else {
                return nil
            }
            let fraction = String(parts[1])
            guard let fractional = Double("0.\(fraction)") else { return nil }
            return base.addingTimeInterval(fractional)
        }
        return archiveUTCPlain.date(from: withoutZ)
    }

    /// Formats `from`/`to` query values for `secure/events` (server uses local wall time, not UTC digits).
    public static func formatEventQuery(_ date: Date) -> String {
        local.string(from: date)
    }

    /// Percent-encodes a query value for Intellect Jersey GET requests (`+` in timezone offset → `%2B`).
    public static func percentEncodedQueryValue(_ value: String) -> String {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "+")
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private static let eventNoFraction = makeFormatter(
        format: "yyyy-MM-dd'T'HH:mm:ssXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )

    private static let archiveUTCNoFraction = makeFormatter(
        format: "yyyyMMdd'T'HHmmssXXX",
        timeZone: TimeZone(identifier: "UTC")!
    )

    private static let archiveUTCPlain = makeFormatter(
        format: "yyyyMMdd'T'HHmmss",
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

