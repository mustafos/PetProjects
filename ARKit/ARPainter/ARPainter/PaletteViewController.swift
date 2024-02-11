import UIKit

class PaletteViewController: UIViewController {
    
    let COLOR_COMPONENT = 0
    let SHAPE_COMPONENT = 1
    
    @IBOutlet weak var brushSettingsPicker: UIPickerView!
    @IBOutlet weak var brushSizeSlider: UISlider!
    @IBOutlet weak var spinningShapesSwitch: UISwitch!
    
    internal var brushSettings: BrushSettings!
    
    struct ColorListItem {
        let name: String
        let color: UIColor
        
        init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }
    
    struct ShapeListItem {
        let name: String
        let shape: BrushSettings.Shape
        
        init(name: String, shape: BrushSettings.Shape) {
            self.name = name
            self.shape = shape
        }
    }
    
    let colors = [
        ColorListItem(name: "Orange", color: UIColor.orange),
        ColorListItem(name: "Blue", color: UIColor.blue),
        ColorListItem(name: "Purple", color: UIColor.purple),
        ColorListItem(name: "Green", color: UIColor.green),
        ColorListItem(name: "White", color: UIColor.white),
        ColorListItem(name: "Brown", color: UIColor.brown),
        ColorListItem(name: "Red", color: UIColor.red),
    ]
    
    let shapes = [
        ShapeListItem(name: "Box", shape: BrushSettings.Shape.box),
        ShapeListItem(name: "Capsule", shape: BrushSettings.Shape.capsule),
        ShapeListItem(name: "Cone", shape: BrushSettings.Shape.cone),
        ShapeListItem(name: "Cylinder", shape: BrushSettings.Shape.cylinder),
        ShapeListItem(name: "Pyramid", shape: BrushSettings.Shape.pyramid),
        ShapeListItem(name: "Sphere", shape: BrushSettings.Shape.sphere),
        ShapeListItem(name: "Torus", shape: BrushSettings.Shape.torus),
        ShapeListItem(name: "Tube", shape: BrushSettings.Shape.tube),
    ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTabBarController = self.tabBarController as! CustomTabBarController
        brushSettings = customTabBarController.brushSettings
        
        brushSettingsPicker.dataSource = self
        brushSettingsPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func brushSizeSliderChanged(_ sender: UISlider) {
        brushSettings.size = CGFloat(sender.value)
    }
    
    @IBAction func spinningShapesSwitchChanged(_ sender: UISwitch) {
        brushSettings.isSpinning = sender.isOn
    }
    
}

extension PaletteViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == COLOR_COMPONENT {
            brushSettings.color = colors[row].color
            pickerView.reloadComponent(SHAPE_COMPONENT)
        } else {
            brushSettings.shape = shapes[row].shape
        }
    }
    
}


extension PaletteViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == COLOR_COMPONENT {
            return colors.count
        } else {
            return shapes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleText: String
        let titleAttributes: [NSAttributedStringKey: Any]
        
        if component == COLOR_COMPONENT {
            titleText = colors[row].name
            titleAttributes = [
                .strokeColor : UIColor.black,
                .foregroundColor : colors[row].color,
                .strokeWidth : -2.0,
                .font : UIFont.boldSystemFont(ofSize: 36)
            ]
            pickerLabel.textAlignment = .right
        } else {
            titleText = "  " + shapes[row].name
            titleAttributes = [
                .strokeColor : UIColor.black,
                .foregroundColor : brushSettings.color,
                .strokeWidth : -2.0,
                .font : UIFont.boldSystemFont(ofSize: 36)
            ]
            pickerLabel.textAlignment = .left
        }
        
        let title = NSAttributedString(string: titleText,
                                       attributes: titleAttributes)
        pickerLabel.attributedText = title
        return pickerLabel
    }
}
