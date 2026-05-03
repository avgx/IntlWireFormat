import Foundation
import Testing
@testable import IntlWireFormat

/// Примеры для этого теста получены через
/// bash-3.2$ websocat 'ws://172.19.2.209:8085/web2/secure/ws/events'
struct IntlWireFormatTests {
    @Test(arguments: [
        (
            """
            {"id":"{294C4C3E-225B-0085-8594-000C290C91E7}","objectId":"CAM:1","ts":"2024-06-04T13:14:03.000+03:00","description":"Запись на диск","camId":null,"addInfo":null,"type":null,"action":"REC","params3":"","params2":"","params1":"","params0":""}
            """,
            "CAM:1",
            "REC"
        ),
    ]) func parse_realPackets(
        string: String,
        expectedObjectId: String,
        expectedAction: String
    ) throws {
        let decoder = JSONDecoder()
        let item = try decoder.decode(IntlWireFormat.Event.self, from: string.data(using: .utf8)!)
        print("\(item)")
        #expect(item.objectId == expectedObjectId)
        #expect(item.action == expectedAction)
    }
}

//TODO: дополнить разные типы из тестов

/*
Test Suite 'Selected tests' started at 2026-04-07 11:43:19.938.
Test Suite 'WebSocketIntegrationTests.xctest' started at 2026-04-07 11:43:19.939.
Test Suite 'WebSocketIntegrationTests.xctest' passed at 2026-04-07 11:43:19.940.
     Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.001) seconds
Test Suite 'Selected tests' passed at 2026-04-07 11:43:19.941.
     Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.003) seconds
◇ Test run started.
↳ Testing Library Version: 1501
↳ Target Platform: x86_64-apple-ios13.0-simulator
◇ Test stringPacketsIntlReadIntegrationTest() started.
2026-04-07T11:43:20+0300 info ws.intl.events: [WebSocket] websocket connected
2026-04-07T11:43:20+0300 debug ws.intl.events: [WebSocket] received string 240 bytes
2026-04-07T11:43:20+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{A76028D0-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:20.102+03:00","description":"Alarm end","camId":null,"addInfo":null,"type":null,"action":"MD_STOP","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:20+0300 debug ws.intl.events: [WebSocket] received string 254 bytes
2026-04-07T11:43:20+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{A86028D0-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:20.102+03:00","description":"Record on disk stopped","camId":null,"addInfo":null,"type":null,"action":"REC_STOP","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:26+0300 debug ws.intl.events: [WebSocket] received string 239 bytes
2026-04-07T11:43:26+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{8DB9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:25.890+03:00","description":"Harddisk rec","camId":null,"addInfo":null,"type":null,"action":"REC","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:26+0300 debug ws.intl.events: [WebSocket] received string 237 bytes
2026-04-07T11:43:26+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{8EB9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:25.890+03:00","description":"Alarm","camId":null,"addInfo":null,"type":null,"action":"MD_START","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:26+0300 debug ws.intl.events: [WebSocket] received string 239 bytes
2026-04-07T11:43:26+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{90B9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:3","ts":"2026-04-07T11:43:26.128+03:00","description":"Harddisk rec","camId":null,"addInfo":null,"type":null,"action":"REC","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:26+0300 debug ws.intl.events: [WebSocket] received string 237 bytes
2026-04-07T11:43:26+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{91B9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:3","ts":"2026-04-07T11:43:26.128+03:00","description":"Alarm","camId":null,"addInfo":null,"type":null,"action":"MD_START","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:28+0300 debug ws.intl.events: [WebSocket] received string 239 bytes
2026-04-07T11:43:28+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{93B9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:28.069+03:00","description":"Harddisk rec","camId":null,"addInfo":null,"type":null,"action":"REC","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:28+0300 debug ws.intl.events: [WebSocket] received string 237 bytes
2026-04-07T11:43:28+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{94B9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:1","ts":"2026-04-07T11:43:28.069+03:00","description":"Alarm","camId":null,"addInfo":null,"type":null,"action":"MD_START","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:34+0300 debug ws.intl.events: [WebSocket] received string 240 bytes
2026-04-07T11:43:34+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{9FB9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:33.864+03:00","description":"Alarm end","camId":null,"addInfo":null,"type":null,"action":"MD_STOP","params0":"","params2":"","params1":"","params3":""}
2026-04-07T11:43:34+0300 debug ws.intl.events: [WebSocket] received string 254 bytes
2026-04-07T11:43:34+0300 info ws.intl.events: [WebSocketIntegrationTests] RECV: {"id":"{A0B9B7D6-5D32-F111-83FD-000C29FF8CC8}","objectId":"CAM:2","ts":"2026-04-07T11:43:33.864+03:00","description":"Record on disk stopped","camId":null,"addInfo":null,"type":null,"action":"REC_STOP","params0":"","params2":"","params1":"","params3":""}
connectionStateUpdates task...
disconnect...
connected
2026-04-07T11:43:34+0300 info ws.intl.events: [WebSocket] websocket disconnected by user
disconnect done.
nw_socket_output_finished [C1:2] shutdown(13, SHUT_WR) [57: Socket is not connected]
disconnected(reason: WebSocket.WebSocket.State.DisconnectReason.userInitiated)
(bytesSent: 0, bytesReceived: 2416)
✔ Test stringPacketsIntlReadIntegrationTest() passed after 14.639 seconds.
✔ Test run with 1 test in 0 suites passed after 14.641 seconds.
Program ended with exit code: 0
*/
