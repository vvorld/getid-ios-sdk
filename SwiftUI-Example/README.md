# GetID SDK SwiftUI Integration Guide

GetID SDK offers a seamless method for incorporating identity verification into your iOS applications. This guide will instruct you on how to integrate the SDK into a SwiftUI-based application.

## Prerequisites

- Ensure you have Xcode installed.
- Be in possession of your `API_URL` and `SDK_KEY` from GetID.

## Integration Steps

1. **Install the GetID SDK**

    Add GetID SDK as a Swift Package:

    - Open your Xcode project.
    - Navigate to `File` > `Swift Packages` > `Add Package Dependency`.
    - Input the URL: `https://github.com/vvorld/getid-ios-sdk` and adhere to the on-screen directions for installation.

2. **Import the SDK**

    Start by importing the GetID SDK into your SwiftUI View.

    ```swift
    import GetID
    ```

3. **Setup the Verification Button with SwiftUI**

    Craft a SwiftUI `Button` to kickstart the verification flow:

    ```swift
    struct VerifyButton: View {
        // ...
        var body: some View {
            Button(action: {
                // SDK initialization logic here
            }) {
                Text("Verify me")
                    .font(.system(size: 25))
            }
        }
    }
    ```

4. **Initiate the Verification Flow**

    Within the action of the button, arrange the SDK's verification routine:

    ```swift
    GetIDSDK.startVerificationFlow(
        apiUrl: "API_URL",
        auth: .sdkKey("SDK_KEY"),
        flowName: "getid-doc-selfie-liveness"
    )
    ```

5. **Manage GetID SDK Callbacks with SwiftUI**

    Implement a Coordinator class to manage delegate responses from the SDK:

    ```swift
    class Coordinator: NSObject, GetIDSDKDelegate {
        ...
    }
    ```

    - `verificationFlowDidStart`: Called when the verification process initiates.
    - `verificationFlowDidCancel`: Called when the user aborts the flow.
    - `verificationFlowDidFail`: Called if a snag is encountered during the flow.
    - `verificationFlowDidComplete`: Called when the flow concludes successfully.

6. **Error Management and Alerts in SwiftUI**

    Utilize SwiftUI's alert modifier to give feedback to the user. It's imperative to manage errors efficiently and keep the user informed:

    ```swift
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    .alert(isPresented: $showAlert) {
        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }
    ```

---

**Note:** Before launching the application, remember to replace `"API_URL"` and `"SDK_KEY"` with your genuine credentials.
