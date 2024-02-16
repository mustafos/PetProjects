import UIKit
import WebKit


class ArtNotesViewController: UIViewController {
  
  @IBOutlet weak var artNotesWebView: WKWebView!
  
  var artworkName: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("artworkName: \(artworkName)")
    if let url = Bundle.main.url(forResource: artworkName, withExtension: "html") {
      artNotesWebView.loadFileURL(url, allowingReadAccessTo: url)
    } else {
      artNotesWebView.loadHTMLString("<h1>Under construction</h1>", baseURL: nil)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
