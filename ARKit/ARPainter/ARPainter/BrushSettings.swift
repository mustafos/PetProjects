import Foundation
import UIKit

class BrushSettings {
    
    enum Shape {
        case box
        case capsule
        case cone
        case cylinder
        case pyramid
        case sphere
        case torus
        case tube
    }
    
    var color = UIColor.orange
    var shape = Shape.box
    var size: CGFloat = 0.5
    var isSpinning = false
    
}
