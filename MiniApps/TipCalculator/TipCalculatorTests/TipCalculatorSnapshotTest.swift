import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTest: XCTestCase {

  private var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
  }
  
  func testLogoView() {
    // given
    let size = CGSize(width: screenWidth, height: 48)
    // when
    let view = LogoView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialResultView() {
    // given
    let size = CGSize(width: screenWidth, height: 224)
    // when
    let view = ResultView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testResultViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 224)
    let result = Result(
      amountPerPerson: 100.25,
      totalBill: 45,
      totalTip: 60)
    // when
    let view = ResultView()
    view.configure(result: result)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialBillInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = BillInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testBillInputViewWithValues() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = BillInputView()
    let textField = view.allSubViewsOf(type: UITextField.self).first
    textField?.text = "500"
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialTipInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56+56+16)
    // when
    let view = TipInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testTipInputViewWithSelection() {
    // given
    let size = CGSize(width: screenWidth, height: 56+56+16)
    // when
    let view = TipInputView()
    let button = view.allSubViewsOf(type: UIButton.self).first
    button?.sendActions(for: .touchUpInside)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }
  
  func testInitialSplitInputView() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = SplitInputView()
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }

  func testSplitInputViewWithSelection() {
    // given
    let size = CGSize(width: screenWidth, height: 56)
    // when
    let view = SplitInputView()
    let button = view.allSubViewsOf(type: UIButton.self).last
    button?.sendActions(for: .touchUpInside)
    // then
    assertSnapshot(matching: view, as: .image(size: size))
  }

}

extension UIView {
  // https://stackoverflow.com/a/45297466/6181721
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T] {
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
}
