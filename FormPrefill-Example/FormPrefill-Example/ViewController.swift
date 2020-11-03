//
//  ViewController.swift
//  FormPrefill-Example
//
//  Created by Mikhail Akopov on 31.01.2020.
//  Copyright © 2020 GetID. All rights reserved.
//

import UIKit
import GetID
import GetIDOCR

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let configuration = Configuration()
        configuration.setFlowItems([.consent, .document, .form, .selfie, .thanks])
        configuration.setFormFields([.firstName, .lastName, .sex, .dateOfBirth])
        configuration.prefillForm = true
        
        let apiKey = "SDK_KEY"
        let url = "API_URL"
        GetIDFactory.makeGetIDViewController(apiKey: apiKey, url: url, configuration: configuration, style: .defaultStyle, customerId: nil, textRecognizer: MRZTextRecognizer(), nfcReader: nil) { [weak self] (vc, error) in
            guard let viewController = vc else {
                print(error ?? "(nil)")
                return
            }
            self?.present(viewController, animated: true, completion: nil)
        }
    }

}

extension MRZTextRecognizer: TextRecognizer {}
