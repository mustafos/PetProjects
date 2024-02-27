import UIKit
import ARKit

class CanvasViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var canvas: ARSCNView!
    @IBOutlet weak var paintButton: UIButton!
    
    internal var brushSettings: BrushSettings!
    
    // When we start the augmented reality (AR) session, we need to specify
    // an AR configuration to use.
    // ARWorldTrackingConfiguration is the full-fidelity configuration
    // that uses the rear camera and does the following:
    //
    // - Tracks the device’s position in 3D space relative to
    //   it starting point (x-, y-, and z-position)
    // - Tracks the device’s orientation (its tilt around the x-,
    //   y-, and z-axes
    // - Detects real-world flat surfaces
    //
    // For this app, we’re concerned only about tracking the device’s
    // position and orientation (a.k.a. the “six degrees of freedom”).
    let configuration = ARWorldTrackingConfiguration()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTabBarController = self.tabBarController as! CustomTabBarController
        brushSettings = customTabBarController.brushSettings
        
        // Set up the AR SceneKit view
        // We’ll handle the ARSCNViewDelegate methods in this class.
        canvas.delegate = self
        
        // This turns on the two available debugging options:
        //
        // 1. showWorldOrigin, which shows the AR session origin,
        //    which is defined by the phone’s location at the start
        //    of the AR session. The origin is marked by the intersection
        //    of 3 line segments:
        //    - x-axis, denoted by a red line segment
        //    - y-axis, denoted by a green line segment
        //    - z-axis, denoted by a blue line segment
        // 2. showFeaturePoints, which represents points on flat
        //    horizontal surfaces that ARKit uses as reference points
        canvas.debugOptions = [ARSCNDebugOptions.showWorldOrigin,
                               ARSCNDebugOptions.showFeaturePoints]
        
        // Turns on SceneKit’s statistics view
        canvas.showsStatistics = true
        
        // Turns on a virtual omnidirectional light source located
        // at the same location as the device.
        canvas.autoenablesDefaultLighting = true
        
        // Starts the AR session.
        canvas.session.run(configuration)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ARSCNViewDelegate methods
    // ===============================
    
    // Called every time the augmented reality scene is about to be rendered
    // (ideally, at least 60 times a second).
    func renderer(_ renderer: SCNSceneRenderer,
                  willRenderScene scene: SCNScene,
                  atTime time: TimeInterval) {
        // A canvas‘ pointOfView is a node representing the camera‘s point of view.
        guard let pointOfView = canvas.pointOfView else { return }
        
        // Get the device’s location, orientation, and position
        // The current location and orientaton of the camera relative to the origin point
        // are embedded in the pointOfView’s transformation matrix (a 4 by 4 matrix).
        let transform = pointOfView.transform
        
        // The orientation is in the 3rd column of the transform matrix.
        let orientation = SCNVector3(-transform.m31,
                                      -transform.m32,
                                      -transform.m33)
        
        // The location is in the 4th column of the transform matrix.
        let location = SCNVector3(transform.m41,
                                  transform.m42,
                                  transform.m43)
        let position = orientation + location
        print("location: \(location)\norientation: \(orientation)")
        
        // By putting this code in a “DispatchQueue.main.async” block,
        // we ensure that this code gets executed in the main queue.
        // We need to do this because we’re removing nodes from the scene
        // and checking the state of the “Paint” button, both of which
        // need to be done in the main queue.
        DispatchQueue.main.async {
            self.eraseNodes(named: "cursor")
            let brush = self.createBrush(brushShape: self.brushSettings.shape,
                                         brushSize: self.brushSettings.size,
                                         position: position)
            if self.paintButton.isHighlighted {
                brush.geometry?.firstMaterial?.diffuse.contents = self.brushSettings.color
                brush.geometry?.firstMaterial?.specular.contents = UIColor.white
                
                if self.brushSettings.isSpinning {
                    let rotateAction = SCNAction.rotate(by: 2 * .pi,
                                                        around: SCNVector3(x: 0, y: 1, z: 0),
                                                        duration: 2)
                    let rotateForeverAction = SCNAction.repeatForever(rotateAction)
                    brush.runAction(rotateForeverAction)
                }
            } else {
                brush.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray
                brush.name = "cursor"
            }
            self.canvas.scene.rootNode.addChildNode(brush)
        }
    }
    
    // MARK: Node creation methods
    // ===========================
    
    // Erase any nodes with the given name.
    func eraseNodes(named nameToErase: String) {
        self.canvas.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == nameToErase {
                node.removeFromParentNode()
            }
        }
    }
    
    // Create a node based on the current brush settings
    // and the camera’s current position.
    func createBrush(brushShape: BrushSettings.Shape,
                     brushSize: CGFloat,
                     position: SCNVector3) -> SCNNode {
        let minSize: CGFloat = 0.02
        let maxSize: CGFloat = 0.5
        let shapeSize = minSize + brushSize * (minSize + maxSize)
        
        let brush: SCNNode!
        
        switch brushShape {
            case .box:
                brush = SCNNode(geometry: SCNBox(width: shapeSize,
                                                 height: shapeSize,
                                                 length: shapeSize,
                                                 chamferRadius: 0))
            case .capsule:
                brush = SCNNode(geometry: SCNCapsule(capRadius: shapeSize / 8,
                                                     height: shapeSize))
                brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
            case .cone:
                brush = SCNNode(geometry: SCNCone(topRadius: 0,
                                                  bottomRadius: shapeSize / 8,
                                                  height: shapeSize))
                brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
            case .cylinder:
                brush = SCNNode(geometry: SCNCylinder(radius: shapeSize / 8,
                                                      height: shapeSize))
                brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
            case .pyramid:
                brush = SCNNode(geometry: SCNPyramid(width: shapeSize,
                                                     height: shapeSize,
                                                     length: shapeSize))
            case .sphere:
                brush = SCNNode(geometry: SCNSphere(radius: shapeSize / 2))
            case .torus:
                brush = SCNNode(geometry: SCNTorus(ringRadius: shapeSize / 2,
                                                   pipeRadius: shapeSize / 8))
                brush.eulerAngles = SCNVector3(Double.pi / 2, 0, 0)
            case .tube:
                brush = SCNNode(geometry: SCNTube(innerRadius: shapeSize / 10,
                                                  outerRadius: shapeSize / 8,
                                                  height: shapeSize))
                brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
        }
        
        brush.position = position
        return brush
    }
}


// MARK: Utility methods
// =====================

// Extend the "+" operator so that it can add two SCNVector3s together.
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x + right.x,
                      left.y + right.y,
                      left.z + right.z)
}
