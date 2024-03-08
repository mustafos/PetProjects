//
//  ViewController.swift
//  UserDefailts
//
//  Created by Mustafa Bekirov on 31.03.2023.
//

import UIKit

enum UserDefaultKeys {
    static let userSettings = "userSettings"
    static let userSettingsStruct = "userSettingsStruct"
    
}

class ViewController: UIViewController {
    var userDefaults = UserDefaults.standard
    let keyForBool = "boolKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let settings = UserSettings(authorized: true)
        
        let settingData = try? NSKeyedArchiver.archivedData(withRootObject: [settings, settings], requiringSecureCoding: false)
        
        userDefaults.set(settingData, forKey: UserDefaultKeys.userSettings)
        
        //Struct
        let encoder = JSONEncoder()
        let settingstStruct = UserSettingStruct(isAuthorized: true)
        let jsonData = try! encoder.encode(settingstStruct)
        
        userDefaults.set(jsonData, forKey: UserDefaultKeys.userSettingsStruct)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let userSettingsData = userDefaults.object(forKey: UserDefaultKeys.userSettings) as? Data,
           let userSettings = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userSettingsData) as? [UserSettings] {
            print("Settings: \(userSettings)")
        }
        
        if let userSettingsData = userDefaults.object(forKey: UserDefaultKeys.userSettingsStruct) as? Data {
            let decoder = JSONDecoder()
            guard let model = try? decoder.decode(UserSettingStruct.self, from: userSettingsData) else { return }
            print("SettingsStruct: \(model)")
        }
    }
}


