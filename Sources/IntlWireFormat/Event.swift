import Foundation


/// Пакет серверных событий
public struct Event: Codable, Sendable {
    ///UUID with `{`and`}` as in default c# uuid serialization.
    public let id: String
    public let objectId: AccessPoint
    /// Timestamp in local format `2024-06-04T13:14:03.000+03:00`
    public let ts: String?
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
}


extension Event: CustomStringConvertible {
    public var description: String {
        "\(objectId)|ts:\(ts ?? "-")|\(text)|id:\(id)"
    }
}

