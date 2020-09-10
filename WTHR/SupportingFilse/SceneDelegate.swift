//
//  SceneDelegate.swift
//  WTHR
//
//  Created by Гена Книжник on 13.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let presentation = PresentationFactory.build()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: presentation.rootView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

