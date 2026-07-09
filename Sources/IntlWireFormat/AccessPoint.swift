import Foundation

/// from intl: extId | monitorId | regionId : "1" , "1.1"
public typealias ObjectID = String
/// from intl: for CAM:1 class is "CAM" (see `AccessPoint.components`)
public typealias ObjectClass = String

/// Intellect object access point: `ObjectClass:ObjectID`, e.g. `CAM:1`, `REGION:1.1`.
public typealias AccessPoint = String

public struct AccessPointComponents: Equatable, Sendable {
    public let objectClass: ObjectClass
    public let objectId: ObjectID

    public init(objectClass: ObjectClass, objectId: ObjectID) {
        self.objectClass = objectClass
        self.objectId = objectId
    }

    public var accessPoint: AccessPoint {
        AccessPoint(objectClass: objectClass, objectId: objectId)
    }
}

extension AccessPoint {
    /// Splits `CAM:1` into class `CAM` and id `1`. Returns `nil` if there is no `:` or class is empty.
    public var components: AccessPointComponents? {
        guard let colon = firstIndex(of: ":") else { return nil }
        let objectClass = String(self[..<colon])
        let objectId = String(self[index(after: colon)...])
        guard !objectClass.isEmpty else { return nil }
        return AccessPointComponents(objectClass: objectClass, objectId: objectId)
    }

    public var objectClass: ObjectClass? { components?.objectClass }
    public var accessPointObjectId: ObjectID? { components?.objectId }

    public init(objectClass: ObjectClass, objectId: ObjectID) {
        self = "\(objectClass):\(objectId)"
    }

    /// `Class:Id` with both components non-empty.
    public var isValidAccessPoint: Bool {
        guard let components else { return false }
        return !components.objectClass.isEmpty && !components.objectId.isEmpty
    }

    public func requireValidAccessPoint() throws -> AccessPoint {
        guard isValidAccessPoint else {
            throw AccessPointValidationError.invalid(self)
        }
        return self
    }
}

public enum AccessPointValidationError: Error, Equatable, Sendable {
    case invalid(AccessPoint)
}
