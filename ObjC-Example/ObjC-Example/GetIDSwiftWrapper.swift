//
//  GetIDSwiftWrapper.swift
//  ObjC-Example
//
//  Created by Mikhail Akopov on 22.03.2021.
//  Copyright © 2021 Mikhail Akopov. All rights reserved.
//

import GetID

@objc final class GetIDSwiftWrapper: NSObject {
    @objc func startVerificationFlow() {
        GetIDSDK.startVerificationFlow(
            apiUrl: "API_URL",
            auth: .sdkKey("SDK_KEY"),
            flowName: "getid-doc-selfie-liveness"
        )
    }
}
