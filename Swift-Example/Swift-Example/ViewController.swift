//
//  ViewController.swift
//  Swift-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

import UIKit
import GetID

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let configuration = Configuration()
        configuration.setFlowItems([.consent, .form, .document, .selfie, .thanks])
        configuration.setFormFields([.firstName, .lastName, .dateOfBirth])
        
        let apiKey = "SDK_KEY"
        let url = "API_URL"
        GetIDFactory.makeGetIDViewController(apiKey: apiKey, url: url, configuration: configuration) { [weak self] (vc, error) in
            guard let viewController = vc else {
                print(error ?? "(nil)")
                return
            }
            self?.present(viewController, animated: true, completion: nil)
        }
    }

}
