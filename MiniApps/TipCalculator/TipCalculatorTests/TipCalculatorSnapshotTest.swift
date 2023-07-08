import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTest: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        let size = CGSize(width: screenWidth, height: 48)
        let view = LogoView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
}

