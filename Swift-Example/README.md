# GetID SDK Integration Guide

GetID SDK provides a seamless way to integrate identity verification into your iOS applications. This guide will walk you through integrating the SDK into a simple `ViewController`.

## Prerequisites

- Ensure you have Xcode installed.
- You need to have your `API_URL` and `SDK_KEY` from GetID.

## Integration Steps

1. **Install the GetID SDK**

    Add GetID SDK as a Swift Package:

    - Open your Xcode project.
    - Go to `File` > `Swift Packages` > `Add Package Dependency`.
    - Enter the following URL: `https://github.com/vvorld/getid-ios-sdk` and follow the on-screen instructions to install.

2. **Import the SDK**

    Once installed, start by importing the GetID SDK into your `ViewController`.
    ```swift
    import GetID
    ```

3. **Setup the Verification Button**

    Create a `UIButton` to trigger the verification flow:
    ```swift
    private lazy var button: UIButton = {
        ...
    }()
    ```

    Don't forget to add the button to your view hierarchy and set its constraints in `viewDidLoad()`.

4. **Start the Verification Flow**

    Add the verification function that will be called when the button is tapped:
    ```swift
    @objc private func verifyMe(_: UIButton) {
        GetIDSDK.startVerificationFlow(
            apiUrl: "API_URL",
            auth: .sdkKey("SDK_KEY"),
            flowName: "getid-doc-selfie-liveness"
        )
    }
    ```

5. **Handle GetID SDK Callbacks**

    Implement the `GetIDSDKDelegate` to handle callbacks from the SDK:
    ```swift
    extension ViewController: GetIDSDKDelegate {
        ...
    }
    ```

    - `verificationFlowDidStart`: Called when the verification flow starts.
    - `verificationFlowDidCancel`: Called if the user cancels the flow.
    - `verificationFlowDidFail`: Called if there's an error during the flow.
    - `verificationFlowDidComplete`: Called upon successful completion.

6. **Error Handling and Alerts**

    It's good practice to handle errors and inform the user about them. You can use the `presentAlert` function to display error messages to the user.

---

Remember to replace `"API_URL"` and `"SDK_KEY"` with your actual values before running the application.

---
