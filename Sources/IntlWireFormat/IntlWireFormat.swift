import Foundation

public enum IntlWireFormat {
    /// Пакет серверных событий
    public struct Event: Codable, Sendable {
        
        public let id: String
        public let objectId: String
        public let ts: String?
        public let text: String
        
        public let action: String?
        
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
}

extension IntlWireFormat.Event: CustomStringConvertible {
    public var description: String {
        "\(objectId)|ts:\(ts ?? "-")|\(text)|id:\(id)"
    }
}

