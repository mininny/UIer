import XCTest
@testable import UIer

final class UIerTests: XCTestCase {
    func testController() {
        let mockDelegate = MockUIerViewDelegate()
        
        let testView = UIView()
        let controller = testView.registerUIerDelegate(mockDelegate, identifier: "identifier")
        controller.addView(testView)
        
        let testView2 = UIView()
        let controller2 = testView2.registerUIerDelegate(mockDelegate, identifier: "identifier")
        
        XCTAssert(controller == controller2)
    }

    static var allTests = [
        ("testController", testController),
    ]
}

class MockUIerViewDelegate: UIerViewDelegate {
    
}
