import UIKit
import ARKit


enum AppState: Int16 {
    case lookingForSurface  // Just starting out; no surfaces detected yet
    case pointToSurface     // Surfaces detected, but device is not pointing to any of them
    case readyToFurnish     // Surfaces detected *and* device is pointing to at least one
}


class RoomViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var statusLabel: UILabel!
    
    var furnitureSettings: FurnitureSettings!
    
    var appState: AppState = .lookingForSurface
    var statusMessage = ""
    var trackingStatus = ""
    
    
    // MARK: - View initializers / events
    // ==================================
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTabBarController = self.tabBarController as! CustomTabBarController
        furnitureSettings = customTabBarController.furnitureSettings
        
        initSceneView()
        initARSession()
        initGestureRecognizers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Intializers
    // ===================
    
    func initSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.showsStatistics = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.antialiasingMode = .multisampling2X
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func createARConfiguration() -> ARConfiguration {
        let config = ARWorldTrackingConfiguration()  // Use "6 degrees of freedom" tracking
        config.worldAlignment = .gravity
        config.planeDetection = [.horizontal, .vertical]
        config.isLightEstimationEnabled = true
        return config
    }
    
    func initARSession() {
        guard ARWorldTrackingConfiguration.isSupported else {
            print("*** ARConfig: AR World Tracking Not Supported")
            return
        }
        
        let config = createARConfiguration()
        sceneView.session.run(config)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        clearAllFurniture()
        resetARsession()
    }
    
    func resetARsession() {
        let config = createARConfiguration()
        sceneView.session.run(config,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
        appState = .lookingForSurface
    }
    
    
    // MARK: - App status
    // ==================
    
    // This method is called once per frame, and we use it to perform tasks
    // that we want performed constantly.
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateAppState()
            self.updateStatusText()
        }
    }
    
    // Updates the app status, based on whether any of the detected planes
    // are currently in view.
    func updateAppState() {
        guard appState == .pointToSurface ||
                appState == .readyToFurnish
        else {
            return
        }
        
        if isAnyPlaneInView() {
            appState = .readyToFurnish
        } else {
            appState = .pointToSurface
        }
    }
    
    // Update the status text at the top of the screen whenever
    // the AR camera tracking state changes.
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
            case .notAvailable:
                trackingStatus = "For some reason, augmented reality tracking isn’t available."
            case .normal:
                trackingStatus = ""
            case .limited(let reason):
                switch reason {
                    case .excessiveMotion:
                        trackingStatus = "You’re moving the device around too quickly. Slow down."
                    case .insufficientFeatures:
                        trackingStatus = "I can’t get a sense of the room. Is something blocking the rear camera?"
                    case .initializing:
                        trackingStatus = "Initializing — please wait a moment..."
                    case .relocalizing:
                        trackingStatus = "Relocalizing — please wait a moment..."
                }
        }
    }
    
    // Updates the status text displayed at the top of the screen.
    func updateStatusText() {
        switch appState {
            case .lookingForSurface:
                statusMessage = "Scan the room with your device until the yellow dots appear."
                sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
            case .pointToSurface:
                statusMessage = "Point your device towards one of the detected surfaces."
                sceneView.debugOptions = []
            case .readyToFurnish:
                statusMessage = "Tap on the floor grid to place furniture; look at walls to place posters."
                sceneView.debugOptions = []
        }
        
        statusLabel.text = trackingStatus != "" ? "\(trackingStatus)" : "\(statusMessage)"
    }
    
    // We can’t check *every* point in the view to see if it contains one of
    // the detected planes. Instead, we assume that the planes that will be detected
    // will intersect with at least one point on a 5*5 grid spanning the entire view.
    func isAnyPlaneInView() -> Bool {
        let screenDivisions = 5 - 1
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        
        for y in 0...screenDivisions {
            let yCoord = CGFloat(y) / CGFloat(screenDivisions) * viewHeight
            for x in 0...screenDivisions {
                let xCoord = CGFloat(x) / CGFloat(screenDivisions) * viewWidth
                let point = CGPoint(x: xCoord, y: yCoord)
                
                // Perform hit test for planes.
                let hitTest = sceneView.hitTest(point, types: .estimatedHorizontalPlane)
                if !hitTest.isEmpty {
                    return true
                }
            }
        }
        return false
    }
    
    
    // MARK: - Plane detection
    // =======================
    
    // This delegate method gets called whenever the node for
    // a *new* AR anchor is added to the scene.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // We only want to deal with plane anchors, which encapsulate
        // the position, orientation, and size, of a detected surface.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Draw the appropriate plane over the detected surface.
        let planeType: String
        if planeAnchor.alignment == .horizontal {
            planeType = "horizontal"
        } else {
            planeType = "vertical"
        }
        print("Found a \(planeType) surface at " +
              "\(planeAnchor.center.x), " +
              "\(planeAnchor.center.y), " +
              "\(planeAnchor.center.z)"
        )
        drawPlaneNode(on: node, for: planeAnchor)
    }
    
    // This delegate method gets called whenever the node for
    // an *existing* AR anchor is updated.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Once again, we only want to deal with plane anchors.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Remove any children this node may have.
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        
        // Update the plane over this surface.
        drawPlaneNode(on: node, for: planeAnchor)
    }
    
    func drawPlaneNode(on node: SCNNode, for planeAnchor: ARPlaneAnchor) {
        // Create a plane node with the same position and size
        // as the detected plane.
        let planeNode = SCNNode(geometry: SCNPlane(
            width: CGFloat(planeAnchor.extent.x),
            height: CGFloat(planeAnchor.extent.z)))
        planeNode.position = SCNVector3(
            planeAnchor.center.x,
            planeAnchor.center.y,
            planeAnchor.center.z)
        planeNode.geometry?.firstMaterial?.isDoubleSided = true
        
        // Align the plane with the anchor.
        planeNode.eulerAngles = SCNVector3(-Double.pi / 2, 0, 0)
        
        // Give the plane node the appropriate surface.
        if planeAnchor.alignment == .horizontal {
            planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "grid")
            planeNode.name = "horizontal"
        } else {
            planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "ray")
            planeNode.name = "vertical"
        }
        
        // Add the plane node to the scene.
        node.addChildNode(planeNode)
        appState = .readyToFurnish
    }
    
    // This delegate method gets called whenever the node corresponding to
    // an existing AR anchor is removed.
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // We only want to deal with plane anchors.
        guard anchor is ARPlaneAnchor else { return }
        
        // Remove any children this node may have.
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
    }
    
    // MARK: - Adding and removing furniture
    // =====================================
    
    func initGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        // Find out where the user tapped on the screen.
        let tappedSceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: tappedSceneView)
        
        // Find all the detected planes that would intersect with
        // a line extending from where the user tapped the screen.
        let planeIntersections = tappedSceneView.hitTest(tapLocation, types: [.estimatedHorizontalPlane])
        
        // If the closest of those planes is horizontal,
        // put the current furniture item on it.
        if !planeIntersections.isEmpty {
            addFurniture(hitTestResult: planeIntersections.first!)
        }
    }
    
    func addFurniture(hitTestResult: ARHitTestResult) {
        // Get the real-world position corresponding to
        // where the user tapped on the screen.
        let transform = hitTestResult.worldTransform
        let positionColumn = transform.columns.3
        let initialPosition = SCNVector3(positionColumn.x,
                                         positionColumn.y,
                                         positionColumn.z)
        // Get the current furniture item, correct its position if necessary,
        // and add it to the scene.
        let node = furnitureSettings.currentFurniturePiece()
        node.position = initialPosition + furnitureSettings.currentFurnitureOffset()
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        clearAllFurniture()
    }
    
    func clearAllFurniture() {
        sceneView.scene.rootNode.enumerateChildNodes { (childNode, _) in
            guard let childNodeName = childNode.name, childNodeName != "horizontal"
            else { return }
            childNode.removeFromParentNode()
        }
    }
    
    
    // MARK: - AR session error management
    // ===================================
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        trackingStatus = "AR session failure: \(error)"
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        trackingStatus = "AR session was interrupted!"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        trackingStatus = "AR session interruption ended."
        resetARsession()
    }
    
}


// MARK: - Utility methods
// =======================

// Extend the "+" operator so that it can add two SCNVector3s together.
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x + right.x,
                      left.y + right.y,
                      left.z + right.z)
}
