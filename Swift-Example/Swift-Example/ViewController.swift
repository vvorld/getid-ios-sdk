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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
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
    
    private func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: GetIDSDKDelegate {
    
    // Called when the GetID verification flow starts.
    func verificationFlowDidStart() {
        print("GetID flow has been started.")
    }
    
    // Called when the GetID verification flow is cancelled by the user.
    func verificationFlowDidCancel() {
        print("GetID flow has been cancelled.")
    }

    // Called when there's an error during the GetID verification flow.
    func verificationFlowDidFail(_ error: GetIDError) {
        let message = "GetID flow has been completed with error: \(error). Description: \(error.localizedDescription)"
        print(message)

        switch error {
        case let .initializationError(error): // Handles initialization errors and presents an alert with the error description.
            presentAlert(error.localizedDescription)
        case .flowError: // Placeholder for handling specific flow errors.
            break
        @unknown default: // Placeholder to handle unknown or future error cases.
            break
        }
    }

    // Called when the GetID verification flow completes successfully.
    func verificationFlowDidComplete(_ application: GetIDApplication) {
        print("GetID flow has been completed, applicationId: \(application.applicationId)")
    }
}


