# IntlWireFormat

A Swift package providing wire-format definitions and decoding for Intl protocol messages.

## Timestamp wire formats

### Events and queries

ISO8601 with milliseconds and offset:

| Example |
|---------|
| `2024-06-04T13:14:03.000+03:00` |
| `2026-04-07T11:43:20.102+03:00` |

Format: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`

### Archive playback

Compact UTC string with milliseconds and offset:

Format: `yyyyMMdd'T'HHmmss.SSSXXX`

### API

```swift
import IntlWireFormat

let date = Timestamp.parseEvent("2026-04-07T11:43:20.102+03:00")

// secure/events query params — local wall time, not UTC digits:
let queryTo = Timestamp.formatEventQuery(Date())

let archive = Timestamp.archiveUTC
let archiveString = archive.string(from: date!)
```

## WebSocket event payloads

See `Event` for JSON event decoding.
