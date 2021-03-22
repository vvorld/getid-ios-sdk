//
//  ViewController.swift
//  Swift-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

import GetID
import UIKit

final class ViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Verify me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(verifyMe), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func verifyMe(_: UIButton) {
        GetIDSDK.startVerificationFlow(
            apiUrl: "API_URL",
            auth: .sdkKey("SDK_KEY"),
            flowName: "getid-doc-selfie-liveness"
        )
    }
}
