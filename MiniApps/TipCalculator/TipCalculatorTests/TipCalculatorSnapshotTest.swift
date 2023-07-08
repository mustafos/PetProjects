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
    
    func testResultViewWithValues() {
        let size = CGSize(width: screenWidth, height: 224)
        let result = Result(amountPerPerson: 100.25,
                            totalBill: 45,
                            totalTip: 60)
        let view = ResultView()
        view.configure(result: result)
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        assertSnapshots(matching: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSlection() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        assertSnapshots(matching: view, as: .image(size: size))
    }
}

extension UIView {
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
