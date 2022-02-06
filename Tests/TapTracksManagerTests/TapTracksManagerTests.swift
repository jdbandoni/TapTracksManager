import XCTest
@testable import TapTracksManager

final class TapTracksManagerTests: XCTestCase {

    private class fakeTouch: UITouch {
        override func location(in view: UIView?) -> CGPoint {
            return CGPoint(x: 10, y: 20)
        }
    }

    private var mockTracksLogger: MockTracksLogger!
    private var mockTracksStorer: MockTracksStorer!
    private var tapTracksManager: TapTracksManager!
    private var view: UIView!

    override func setUp() {
        mockTracksLogger = MockTracksLogger()
        mockTracksStorer = MockTracksStorer()
        tapTracksManager = TapTracksManager(logger: mockTracksLogger, storer: mockTracksStorer)
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tapTracksManager.startTracking(view: view)
    }

    func testWhenAppMovedBackgroundShouldLog() {
        let notificationExpectation = expectation(description: "wait for notification arriving")
        XCTAssertEqual(mockTracksLogger.logInvokedCount, 0)
        XCTAssertEqual(mockTracksStorer.saveInvokedCount, 0)
        XCTAssertEqual(mockTracksStorer.loadInvokedCount, 0)
        XCTAssertEqual(mockTracksLogger.lastTapTracksLogged.count, 0)

        NotificationCenter.default.post(name: UIApplication.didEnterBackgroundNotification, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            notificationExpectation.fulfill()
        }

        wait(for: [notificationExpectation], timeout: 1)

        XCTAssertEqual(mockTracksStorer.saveInvokedCount, 0)
        XCTAssertEqual(mockTracksStorer.loadInvokedCount, 1)
        XCTAssertEqual(mockTracksLogger.logInvokedCount, 1)
    }

    func testWhenTapOccursShouldSaveIt() {
        XCTAssertEqual(mockTracksStorer.saveInvokedCount, 0)

        guard let gestureRecognizer = view.gestureRecognizers?.first else {
            XCTFail("Missing tap gesture")
            return
        }

        XCTAssertEqual(tapTracksManager.gestureRecognizer(gestureRecognizer, shouldReceive: fakeTouch()), false)
        XCTAssertEqual(mockTracksStorer.saveInvokedCount, 1)
        XCTAssertEqual(mockTracksStorer.lastTapTrackSaved?.coordinates, CGPoint(x: 10, y: 20))
    }
}
