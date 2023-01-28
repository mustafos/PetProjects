import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Dispatch Group"

class DispatchGrouptest1 {
    private let queueSerial = DispatchQueue(label: "mustafos")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("finish all")
        }
    }
}

let dispatchGrouptest1 = DispatchGrouptest1()
//dispatchGrouptest1.loadInfo()


class DispatchGrouptest2 {
    private let queueConcurrent = DispatchQueue(label: "mustafos", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConcurrent.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConcurrent.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        
        print("finish all")
        
        groupBlack.notify(queue: .main) {
            print("groupBlack finish all")
        }
    }
}

let dispatchGrouptest2 = DispatchGrouptest2()
//dispatchGrouptest2.loadInfo()

// ======================== Example ========================

let imageURLs = ["https://pixy.org/src/21/219269.jpg", "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg", "https://www.freepsdbazaar.com/wp-content/uploads/2020/06/fire-works/fireworks-108.jpg", "https://cbeyondata.com/wp-content/uploads/2020/10/iStock-1237546531-1920x1280.jpg"]

class EightItem: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightItem(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = UIColor.cyan

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL,
                runQueue: DispatchQueue,
                completionQueue: DispatchQueue,
                complition: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async { complition(UIImage(data: data), nil) }
        } catch let error {
            completionQueue.async { complition(nil, error) }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...3 {
        aGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                       runQueue: .global(),
                       completionQueue: .main) { (result, error) in
            guard let image1 = result else { return }
            images.append(image1)
            aGroup.leave()
        }
    }
    
    aGroup.notify(queue: .main) {
        for i in 0...3 {
            view.ivs[i].image = images[i]
        }
    }
}

func asyncUrlSession() {
    for i in 4...7 {
        let url = URL(string: imageURLs[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

asyncUrlSession()
asyncGroup()
