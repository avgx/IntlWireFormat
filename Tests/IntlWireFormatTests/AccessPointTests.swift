import Foundation
import Testing
@testable import IntlWireFormat

@Test func accessPointSplitsClassAndId() {
    let ap: AccessPoint = "CAM:34"
    #expect(ap.objectClass == "CAM")
    #expect(ap.accessPointObjectId == "34")
    #expect(ap.components == AccessPointComponents(objectClass: "CAM", objectId: "34"))
}

@Test func accessPointSupportsDottedObjectId() {
    let ap: AccessPoint = "REGION:1.1"
    #expect(ap.objectClass == "REGION")
    #expect(ap.accessPointObjectId == "1.1")
}

@Test func accessPointBuildsFromComponents() {
    let ap = AccessPoint(objectClass: "STREAMING_SERVER", objectId: "1")
    #expect(ap == "STREAMING_SERVER:1")
    #expect(ap.components?.objectClass == "STREAMING_SERVER")
}

@Test func accessPointWithoutObjectId() {
    #expect(AccessPoint("GRAY:").objectClass == "GRAY")
    #expect(AccessPoint("GRAY:").accessPointObjectId == "")
    #expect(AccessPoint("no-colon").components == nil)
    #expect(!AccessPoint("GRAY:").isValidAccessPoint)
}

@Test func accessPointValidWhenBothComponentsPresent() {
    #expect(AccessPoint("CAM:34").isValidAccessPoint)
    #expect(!AccessPoint("CAM:").isValidAccessPoint)
    #expect(!AccessPoint("no-colon").isValidAccessPoint)
    #expect(AccessPoint("REGION:1.1").isValidAccessPoint)
    #expect(!AccessPoint("LINK:null").isValidAccessPoint)
    #expect(!AccessPoint("LINK:NULL").isValidAccessPoint)
}
