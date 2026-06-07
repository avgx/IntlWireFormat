import Foundation
import Testing
@testable import IntlWireFormat

struct TimestampTests {
    private let utc = Timestamp.utc
    private let archiveUTC = Timestamp.archiveUTC

    @Test(arguments: [
        "2024-06-04T13:14:03.000+03:00",
        "2026-04-07T11:43:20.102+03:00",
    ]) func parse_eventTimestamps(string: String) {
        let date = utc.date(from: string)
        #expect(date != nil)
    }

    @Test func roundTrip_utc() throws {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(identifier: "UTC"),
            year: 2026,
            month: 4,
            day: 7,
            hour: 11,
            minute: 43,
            second: 20,
            nanosecond: 102_000_000
        )
        let original = try #require(components.date)
        let formatted = utc.string(from: original)
        let parsed = utc.date(from: formatted)
        #expect(parsed != nil)
        #expect(abs(original.timeIntervalSince(parsed!)) < 0.001)
    }

    @Test func archiveUTC_matchesExpectedPattern() throws {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(identifier: "UTC"),
            year: 2013,
            month: 12,
            day: 3,
            hour: 17,
            minute: 26,
            second: 0
        )
        let date = try #require(components.date)
        let formatted = archiveUTC.string(from: date)
        let pattern = #"^\d{8}T\d{6}\.\d{3}(Z|[+-]\d{2}:\d{2})$"#
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(formatted.startIndex..<formatted.endIndex, in: formatted)
        #expect(regex.firstMatch(in: formatted, range: range) != nil)
    }

    @Test func localFormatter_usesCurrentTimeZone() {
        #expect(Timestamp.local.timeZone == TimeZone.current)
    }

    @Test func percentEncodedQueryValue_encodesPlusInOffset() {
        let encoded = Timestamp.percentEncodedQueryValue("2026-06-07T00:00:00.000+03:00")
        #expect(encoded == "2026-06-07T00:00:00.000%2B03:00")
    }

    @Test func utcFormatter_usesUTC() {
        #expect(Timestamp.utc.timeZone == TimeZone(identifier: "UTC"))
    }

    @Test func archiveUTC_usesUTC() {
        #expect(Timestamp.archiveUTC.timeZone == TimeZone(identifier: "UTC"))
    }
}
