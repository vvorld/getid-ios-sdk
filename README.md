# GetID iOS SDK

## Table of contents
*   [Overview](#overview)
*   [Getting started](#getting-started)
    *   [Requirements](#requirements)
    *   [Obtaining an SDK key](#obtaining-an-sdk-key)
    *   [Camera usage description](#camera-usage-description)
    *   [Using in Objective-C apps](#using-in-objective-c-apps)
*   [Installation](#installation)
    *   [Cocoapods](#cocoapods)
    *   [Carthage](#carthage)
    *   [Swift Package Manager](#swift-package-manager)
*   [Usage](#usage)
    *   [Starting the flow](#starting-the-flow)
    *   [External IDs](#external-ids)
    *   [Profile data](#profile-data)
    *   [Acceptable documents](#acceptable-documents)
    *   [Metadata](#metadata)
    *   [Locale](#locale)
    *   [Custom dictionary](#custom-dictionary)
    *   [Handling callbacks](#handling-callbacks)
    *   [Possible errors](#possible-errors)
*   [Localisation](#localisation)

## Overview
The GetID SDK offers a comprehensive toolkit for capturing identity documents, facial photos, profile information, and performing liveness checks. Once captured, the data is sent to the GetID server.

> **Note**: The SDK does not support methods for fetching verification results. Use the GetID API on your server for this purpose.

For instructions on how to use version `2.0.0` or newer, proceed below. For older versions, see [here](Docs/v1/README-v1.md).

## Getting started
### Requirements
- Xcode 14.1+
- Swift 5.0+
- iOS 12+

### Obtaining an SDK key
Start by fetching the `SDK KEY` and `API URL`:

- Access these from your GetID Dashboard.
- Alternatively, contact our [integration support](mailto:support@getid.ee?subject=[GitHub]%20Obtaining%20GetID%20credentials).

> **Security Reminder**: Your GetID Dashboard provides both `API KEY` and `SDK KEY`. While the `API KEY` allows for public and SDK API calls, the `SDK KEY` is exclusive to SDK API calls. It's safer to use `SDK KEY` in your SDK.

Note: In your GetID Dashboard, you can get and set `API KEY` and `SDK KEY`. `API KEY` grants you access to public API calls and SDK API calls. `SDK KEY` grants you access to SDK API calls only. For security reasons, strongly recommended using the `SDK KEY` in your SDK.

### Camera Permissions
Ensure the SDK can access the device camera:

- Add the `NSCameraUsageDescription` to the app's Info.plist to explain why you need camera access.

### Integration with Objective-C Apps
For apps written in Objective-C:

- Set `Always Embed Swift Standard Libraries` to `YES` in your app's build settings.
- Detailed integration instructions are available in [this document](Docs/Objective-C.md).

## Installation

### Cocoapods
GetID SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:
```ruby
pod 'GetID', '~> 2.9'
```

### Carthage
GetID SDK is compatible with [Carthage](https://github.com/Carthage/Carthage). Add it to your `Cartfile`:
```ogdl
github "vvorld/getid-ios-sdk" ~> 2.9
```

### Swift Package Manager
Go to `File > Swift Packages > Add Package Dependency`. Use this repository's URL with a version of `2.9.0` or above.

## Usage
Before you start please go to GetID Admin Panel and create a flow (Flows > Add new flow).

### Starting the flow
There are two ways to start the verification flow: using the `SDK KEY` or using a `JWT`. We recommend using JWT in the production environment. But during the development, you can use `SDK KEY`, because it's a little bit more convenient.

At first, import `GetID` to a `.swift` file from which you plan to start the verification flow.
```swift
import GetID
```

Then call `GetIDSDK.startVerificationFlow` method from the place in your code that responds to starting the verification flow. For example, it can be a handler of a button touch event.
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .sdkKey("SDK_KEY"),
  flowName: "FLOW_NAME"
)
```

To start the verification flow using a `JWT`, your app should obtain the token from your backend. 
Your backend should have the `SDK KEY` to request the token from GetID server. Don't store `SDK KEY` inside the app in the production environment.

To test starting the flow using a `JWT`, you can obtain one. To obtain a `JWT` make a POST request on your `API URL` with `SDK KEY` in the header:
```bash
$ curl -H "Content-Type: application/json" -H "x-sdk-key: SDK_KEY" -X POST API_URL/sdk/v2/token
```

Then pass the received token to `GetIDSDK.startVerificationFlow` method:
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME"
)
```

### External IDs
There are two different external IDs that can be used to link a verification with a user in your system: `customerId` and `externalId`. See the details in [this document](Docs/ExternalIDs.md).

### Profile data
If you have some information about the user before the verification flow started, you can pass it to the SDK as `profileData`. 

The SDK can use this data to prefill the form if the flow contains the `Profile Data` step. The user can edit this information while filling out the form.

If the form does not contain a `profileData` field (or there is no `Profile Data` step in the flow) then this field will be sent to the GetID server without the user's edit.

```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME",
  profileData: .init(["first-name": "John", "gender": "male"])
)
```

You can find more details on field names and their format in [this document](Docs/ProfileData.md).

### Acceptable documents
It's possible to limit the list of acceptable documents and issuing countries.
In order to do that pass `acceptableDocuments` parameter to `GetIDSDK.startVerificationFlow` method.
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME",
  acceptableDocuments: .init(["EST": [.passport, .idCard], .default: [.passport]])
)
```
See more details on setting acceptable document types and countries in [this document](Docs/AcceptableDocuments.md).

### Metadata
You can attach some metadata to a verification.
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME",
  metadata: .init(labels: ["department": "EST"])
)
```

### Locale
By default, the SDK gets the list of device's preferred languages (it can be more than one on an iOS device) and chooses the best match from the list of [supported languages](#localisation). So you don't have to set up the language of the verification flow's UI.

But if you want to override the default behavior by some reason, then pass `locale` to `GetIDSDK.startVerificationFlow` method.
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME",
  locale: "et"
)
```

### Custom dictionary
If you want to change some texts in the UI, then you have to upload one or more dictionaries to our backend. Our API documentation describes how to do that [on this page](https://developers.getid.ee/docs/post-create-dictionary). Once a dictionary is uploaded, pass its name as the `dictionary` parameter to the SDK initializer.
```swift
GetIDSDK.startVerificationFlow(
  apiUrl: "API_URL",
  auth: .jwt("JWT"),
  flowName: "FLOW_NAME",
  dictionary: "custom-dictionary-name"
)
```

### Handling callbacks
If you want to handle the verification process completion then assign an object that conforms to `GetIDSDKDelegate` protocol to `delegate` property of `GetIDSDK`. 

| `GetIDSDKDelegate` method | Description |
| ----- | ----- |
| `verificationFlowDidStart()` | Tells the delegate that the verification flow has been successfully started. |
| `verificationFlowDidComplete(_:)` | Tells the delegate that the user has completed the verification flow. The `applicationId` property of `application` parameter can be used for getting the verification status. |
| `verificationFlowDidCancel()` | Tells the delegate that the user has cancelled the verification flow. |
| `verificationFlowDidFail(_:)` | Tells the delegate that the verification flow has been failed. |

Here is an example of handling GetID SDK callbacks:
```swift
import GetID

final class ViewController: UIViewController {
  ...

  func startFlow() {
    GetIDSDK.delegate = self
    GetIDSDK.startVerificationFlow(
      apiUrl: "API_URL",
      auth: .jwt("JWT"),
      flowName: "FLOW_NAME"
    )
  }
}

extension ViewController: GetIDSDKDelegate {
  func verificationFlowDidStart() {
    print("GetID flow has been started.")
  }

  func verificationFlowDidCancel() {
    print("GetID flow has been cancelled.")
  }

  func verificationFlowDidFail(_ error: GetIDError) {
    print("GetID flow has been completed with error: \(error). Description: \(error.localizedDescription)")
  }

  func verificationFlowDidComplete(_ application: GetIDApplication) {
    print("GetID flow has been completed, applicationId: \(application.applicationId)")
  }
}
```

### Possible errors
There are two types of errors that can occur in GetID SDK: `GetIDError.InitializationError` and `GetIDError.FlowError`.
The first one can occur during SDK initialization. `GetIDError.FlowError` can occur while the user is passing the verification flow. Both of the types are enums, see the list of all possible cases in the tables below.

| `GetIDError.InitializationError` | Description |
| ----- | ----- |
| `invalidURL` | Invalid `API_URL`. The correct one is the address of your GetID Dashboard, for example `https://company-name.getid.ee`. |
| `invalidFlowName` | Invalid `flowName`. |
| `invalidKey` | Invalid `SDK_KEY`. |
| `invalidToken` | Invalid `JWT`. Maybe, it has been expired. |
| `flowNotFound` | There is no flow with the name you passed as `flowName`. See all the possible names in GetID Dashboard, at the `Flows` tab. |
| `unsupportedSchemaVersion(version:supportedVersions:)` | It means that the SDK version is outdated. Note: `schemaVersion != sdkVersion`. |
| `applicationWithThisCustomerIdAlreadyExists` | An application with this `customerId` already exists. |

| `GetIDError.FlowError` | Description |
| ----- | ----- |
| `tokenExpired` | The token has been expired. |
| `unsupportedLivenessVersion(version:)` | It means that the SDK version is outdated. |
| `applicationWithThisCustomerIdAlreadyExists` | An application with this `customerId` already exists. |
| `failedToSendApplication(underlyingError:)` | The SDK failed to send the captured data to the server (because of an network error, for example). |

## Localisation
GetID iOS SDK loads translations from the server at launch. The SDK also gets the user's preferred languages list from the operating system. Then the SDK compares this list with available translations and picks the best match.

It works automatically and doesn't require any additional configuration.

The list of supported languages:
- English (`en`)
- German (`de`)
- French (`fr`)
- Spanish (`es_ES`)
- Russian (`ru`)
- Portuguese (`pt_PT`)
- Brazilian Portuguese (`pt_BR`)
- Italian (`it`)
- Polish (`pl`)
- Ukrainian (`uk`)
- Dutch (`nl`)
- Swedish (`sv`)
- Danish (`da`)
- Greek (`el`)
- Czech (`cs`)
- Bulgarian (`bg`)
- Romanian (`ro`)
- Hungarian (`hu`)
- Slovenian (`sl`)
- Croatian (`hr`)
- Bosnian (`bs`)
- Albanian (`sq`)
- Macedonian (`mk`)
- Estonian (`et`)
- Lithuanian (`lt`)
- Latvian (`lv`)
- Finnish (`fi`)
- Turkish (`tr`)
- Japanese (`ja`)
- Korean (`ko`)
- Indonesian (`id`)
- Malay (`ms`)
- Thai (`th`)
- Vietnamese (`vi`)
- Chinese (`zh`)
- Arabic (`ar`)
- Persian (`fa`)
