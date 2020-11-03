//
//  ContentView.swift
//  SwiftUI-Example
//
//  Created by Mikhail Akopov on 14.02.2020.
//  Copyright © 2020 GetID. All rights reserved.
//

import SwiftUI
import GetID

struct ContentView: View {
        
    var body: some View {
        Button(action: {
            guard let rootController = getRootController() else { return }

            let configuration = Configuration()
            configuration.setFlowItems([.consent, .document, .selfie, .thanks])

            let apiKey = "SDK_KEY"
            let url = "API_URL"

            GetIDFactory.makeGetIDViewController(apiKey: apiKey, url: url, configuration: configuration) { (vc, error) in
                guard let viewController = vc else { return }
                rootController.present(viewController, animated: true, completion: nil)
            }
        }) {
            Text("Verify me")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


fileprivate func getRootController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes.compactMap {
        $0 as? UIWindowScene
    }
  
    guard !scenes.isEmpty else { return nil }
    for scene in scenes {
        guard let root = scene.windows.first?.rootViewController else {
            continue
        }
        return root
    }
    return nil
}
