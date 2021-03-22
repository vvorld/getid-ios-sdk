//
//  ContentView.swift
//  SwiftUI-Example
//
//  Created by Mikhail Akopov on 14.02.2020.
//  Copyright © 2020 GetID. All rights reserved.
//

import GetID
import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            GetIDSDK.startVerificationFlow(
                apiUrl: "API_URL",
                auth: .sdkKey("SDK_KEY"),
                flowName: "getid-doc-selfie"
            )
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
