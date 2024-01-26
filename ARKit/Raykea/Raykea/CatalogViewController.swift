import Foundation
import UIKit
import SceneKit


class CatalogViewController: UIViewController {

  @IBOutlet var furnitureCollectionView: UICollectionView!
  
  var furnitureSettings: FurnitureSettings!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let customTabBarController = self.tabBarController as! CustomTabBarController
    furnitureSettings = customTabBarController.furnitureSettings

    furnitureCollectionView.dataSource = self
    furnitureCollectionView.delegate = self
  }

}

extension CatalogViewController : UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    furnitureSettings.furniture = indexPath.row
    tabBarController?.selectedIndex = 0
  }
  
}

extension CatalogViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return furnitureSettings.furnitureNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = furnitureCollectionView.dequeueReusableCell(withReuseIdentifier: "furnitureCollectionViewCell", for: indexPath)
    print("indexPath.row: \(indexPath.row)")
    
    let furniturePic = cell.viewWithTag(1000) as! UIImageView
    furniturePic.image = furnitureSettings.furniturePictures[indexPath.row]
    
    let nameLabel = cell.viewWithTag(1001) as! UILabel
    nameLabel.text = furnitureSettings.furnitureNames[indexPath.row]
    
    let descriptionLabel = cell.viewWithTag(1002) as! UILabel
    descriptionLabel.text = furnitureSettings.furnitureDescriptions[indexPath.row]
    
    return cell
  }
}
