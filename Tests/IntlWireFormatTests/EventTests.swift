import Foundation
import Testing
@testable import IntlWireFormat

/// Примеры для этого теста получены через
/// `websocat 'ws://…/web2/secure/ws/events'` (реальные RECV из интеграционного прогона).
struct IntlWireFormatTests {
    @Test(arguments: [
        (
            """
            {"id":"{294C4C3E-225B-0085-8594-000C290C91E7}","objectId":"CAM:1","ts":"2024-06-04T13:14:03.000+03:00","description":"Запись на диск","camId":null,"addInfo":null,"type":null,"action":"REC","params3":"","params2":"","params1":"","params0":""}
            """,
            "CAM:1",
            "REC",
            "Запись на диск"
        ),
        (
            """
            {"id":"{A76028D0-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:20.102+03:00","description":"Alarm end","camId":null,"addInfo":null,"type":null,"action":"MD_STOP","params0":"","params2":"","params1":"","params3":""}
            """,
            "CAM:1",
            "MD_STOP",
            "Alarm end"
        ),
        (
            """
            {"id":"{A86028D0-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:20.102+03:00","description":"Record on disk stopped","camId":null,"addInfo":null,"type":null,"action":"REC_STOP","params0":"","params2":"","params1":"","params3":""}
            """,
            "CAM:1",
            "REC_STOP",
            "Record on disk stopped"
        ),
        (
            """
            {"id":"{8DB9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:25.890+03:00","description":"Harddisk rec","camId":null,"addInfo":null,"type":null,"action":"REC","params0":"","params2":"","params1":"","params3":""}
            """,
            "CAM:2",
            "REC",
            "Harddisk rec"
        ),
        (
            """
            {"id":"{8EB9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:25.890+03:00","description":"Alarm","camId":null,"addInfo":null,"type":null,"action":"MD_START","params0":"","params2":"","params1":"","params3":""}
            """,
            "CAM:2",
            "MD_START",
            "Alarm"
        ),
    ]) func parse_realPackets(
        string: String,
        expectedObjectId: String,
        expectedAction: String,
        expectedText: String
    ) throws {
        let decoder = JSONDecoder()
        let item = try decoder.decode(Event.self, from: string.data(using: .utf8)!)
        #expect(item.objectId == expectedObjectId)
        #expect(item.action == expectedAction)
        #expect(item.text == expectedText)
    }
}
