import Foundation

/// Пакет серверных событий
public struct Event: Codable, Sendable {
    ///UUID with `{`and`}` as in default c# uuid serialization.
    public let id: String
    public let objectId: AccessPoint
    /// Raw timestamp from JSON, e.g. `2024-06-04T13:14:03.000+03:00`
    public let ts: String?
    /// Parsed from ``ts`` during decoding via ``Timestamp/parseEvent(_:)``.
    public let timestamp: Date?
    public let text: String
    //TODO: SafeEnum. Need to get an access to fully configured backend to fill it
    public let action: String?
    //TODO: linked ObjectID or AccessPoint for ULPR event. Need to check on real data
    public let camId: String?
    public let type: String?

    public let params0: String?
    public let params1: String?
    public let params2: String?
    public let params3: String?

    //TODO: addInfo

    enum CodingKeys: String, CodingKey {
        case id
        case objectId
        case ts
        case text = "description"
        case action
        case camId
        case type
        case params0
        case params1
        case params2
        case params3
    }

    public init(
        id: String,
        objectId: AccessPoint,
        ts: String? = nil,
        timestamp: Date? = nil,
        text: String,
        action: String? = nil,
        camId: String? = nil,
        type: String? = nil,
        params0: String? = nil,
        params1: String? = nil,
        params2: String? = nil,
        params3: String? = nil
    ) {
        self.id = id
        self.objectId = objectId
        self.ts = ts
        self.timestamp = timestamp ?? ts.flatMap(Timestamp.parseEvent)
        self.text = text
        self.action = action
        self.camId = camId
        self.type = type
        self.params0 = params0
        self.params1 = params1
        self.params2 = params2
        self.params3 = params3
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        objectId = try container.decode(AccessPoint.self, forKey: .objectId)
        ts = try container.decodeIfPresent(String.self, forKey: .ts)
        timestamp = ts.flatMap(Timestamp.parseEvent)
        text = try container.decode(String.self, forKey: .text)
        action = try container.decodeIfPresent(String.self, forKey: .action)
        camId = try container.decodeIfPresent(String.self, forKey: .camId)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        params0 = try container.decodeIfPresent(String.self, forKey: .params0)
        params1 = try container.decodeIfPresent(String.self, forKey: .params1)
        params2 = try container.decodeIfPresent(String.self, forKey: .params2)
        params3 = try container.decodeIfPresent(String.self, forKey: .params3)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(objectId, forKey: .objectId)
        try container.encodeIfPresent(ts, forKey: .ts)
        try container.encode(text, forKey: .text)
        try container.encodeIfPresent(action, forKey: .action)
        try container.encodeIfPresent(camId, forKey: .camId)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(params0, forKey: .params0)
        try container.encodeIfPresent(params1, forKey: .params1)
        try container.encodeIfPresent(params2, forKey: .params2)
        try container.encodeIfPresent(params3, forKey: .params3)
    }
}

extension Event: CustomStringConvertible {
    public var description: String {
        "\(objectId)|ts:\(ts ?? "-")|\(text)|id:\(id)"
    }
}
