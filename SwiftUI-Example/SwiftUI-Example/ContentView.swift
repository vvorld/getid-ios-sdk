//
//  ContentView.swift
//  SwiftUI-Example
//
//  Created by Mikhail Akopov on 14.02.2020.
//  Copyright © 2020 GetID. All rights reserved.
//
import GetID
import SwiftUI
import Combine

struct ContentView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            VerifyButton(showAlert: $showAlert, alertMessage: $alertMessage)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
    }
}

struct VerifyButton: View {
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    @State private var coordinator = Coordinator()

    var body: some View {
        Button(action: {
            coordinator.parent = self
            GetIDSDK.delegate = coordinator
            GetIDSDK.startVerificationFlow(
                apiUrl: "API_URL",
                auth: .sdkKey("SDK_KEY"),
                flowName: "getid-doc-selfie-liveness"
            )
        }) {
            Text("Verify me")
                .font(.system(size: 25))
        }
    }

    class Coordinator: NSObject, GetIDSDKDelegate {
        var parent: VerifyButton?

        func verificationFlowDidStart() {
            print("GetID flow has been started.")
        }

        func verificationFlowDidCancel() {
            print("GetID flow has been cancelled.")
        }

        func verificationFlowDidFail(_ error: GetIDError) {
            let message = "GetID flow has been completed with error: \(error). Description: \(error.localizedDescription)"
            print(message)

            switch error {
            case let .initializationError(error):
                parent?.alertMessage = error.localizedDescription
                parent?.showAlert = true
            case .flowError:
                break
            @unknown default:
                break
            }
        }

        func verificationFlowDidComplete(_ application: GetIDApplication) {
            print("GetID flow has been completed, applicationId: \(application.applicationId)")
        }
    }
}
