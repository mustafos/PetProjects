//
//  SceneDelegate.swift
//  PunkIPA
//
//  Created by Roman Rechich on 09.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = setupInitialViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
    
    func setupInitialViewController() -> UIViewController {
        RickAndMortyCharacterListView(
            viewModel: RickAndMortyCharacterViewModel(
                imageDownaloader: DefaultImageDownloader(
                    imageCache: DefaultImageCache(),
                    session: URLSession.shared
                ),
                rickAndMortyAPI: RickAndMortyCharacterNetworkService(
                    baseURL: URL(string: "https://rickandmortyapi.com/api")!,
                    session: URLSession.shared
                )
            )
        )
    }
}
