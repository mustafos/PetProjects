import Foundation
import UIKit
import ARKit

class FurnitureSettings {

  let furniturePictures = [
    UIImage(named: "bookshelf-pic"),
    UIImage(named: "chair-pic"),
    UIImage(named: "couch-pic"),
    UIImage(named: "table-pic"),
    ]
  let furnitureNames = [
    "BIBLIOTEK",
    "BÜTTPLAIZE",
    "DERP",
    "TEBBEL",
    ]
  let furnitureDescriptions = [
    "Do you have a thing called...books? Do you have a place to put them? No? You need this.",
    "Standing is for suckers. Sitting is the new standing. Park your butt in...BÜTTPLAIZE!",
    "Need a place to eat chips and binge-watch Netflix for hours? You need DERP.",
    "Free your hands by putting your plate and glass on TEBBEL.",
    ]
  let furnitureOffsets = [
    SCNVector3(0, 0, 0),
    SCNVector3(0, 0.32, 0),
    SCNVector3(0, 0, 0),
    SCNVector3(0, 0, 0),
    ]

  var furniture = 0

  func currentFurniturePiece() -> SCNNode {
    switch furniture {
    case 0:
      return createBookshelf()
    case 1:
      return createChair()
    case 2:
      return createCouch()
    case 3:
      return createTable()
    default:
      return createBookshelf()
    }
  }

  func currentFurnitureOffset() -> SCNVector3 {
    return furnitureOffsets[furniture]
  }

  func createBookshelf() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "bookcase", recursively: false))!
    return node
  }

  func createChair() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "chair", recursively: false))!
    return node
  }

  func createCouch() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "couch", recursively: false))!
    return node
  }

  func createTable() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "table", recursively: false))!
    return node
  }

}

