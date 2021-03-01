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
    *   [Profile data](#profile-data)
    *   [Metadata](#metadata)
    *   [Locale](#locale)
    *   [Handling callbacks](#handling-callbacks)
    *   [Possible errors](#possible-errors)
*   [Localisation](#localisation)

## Overview
The SDK provides a set of screens for capturing identity documents, face photos, profile data, and for performing the liveness check. After capturing the data the SDK uploads it to the GetID server.

The SDK does not provide methods for obtaining verification results. Use GetID API on your backend to get ones.

This document describes how to use the version `2.0.0` or newer. The documentation for older versions is [here](Docs/v1/README-v1.md).

## Getting started
### Requirements
- Xcode 10.2+
- Swift 5.0+
- iOS 11+

### Obtaining an SDK key
In order to start using GetID SDK, you will need an `SDK KEY` and `API URL`.
Both can be found and modified either through your GetID Dashboard or via contacting our 
[integration support](mailto:support@getid.ee?subject=[GitHub]%20Obtaining%20GetID%20credentials).

Note: In your GetID Dashboard, you can get and set `API KEY` and `SDK KEY`. `API KEY` grants you access to public API calls and SDK API calls. `SDK KEY` grants you access to SDK API calls only. For security reasons, strongly recommended using the `SDK KEY` in your SDK.

### Camera usage description
The SDK uses the camera for capturing photos during verification. The app is responsible for describing the reason for using the camera. You must add `NSCameraUsageDescription` to the Info.plist of the app.

### Using in Objective-C apps
If you app is written entirely in Objective-C, you should set `Always Embed Swift Standard Libraries` to `YES` in your app target's build settings.

## Installation

### Cocoapods
GetID SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:
```ruby
pod 'GetID', '~> 2.0'
```

### Carthage
GetID SDK is compatible with [Carthage](https://github.com/Carthage/Carthage). Add it to your `Cartfile`:
```ogdl
github "vvorld/getid-ios-sdk" ~> 2.0
```

### Swift Package Manager
In Xcode (11.2+), select File > Swift Packages > Add Package Dependency.
Follow the prompts using the URL for this repository and a minimum semantic version of `2.0.0`.

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
- Dutch (`nl`)
- Greek (`el`)
- Bulgarian (`bg`)
- Romanian (`ro`)
- Hungarian (`hu`)
- Slovenian (`sl`)
- Bosnian (`bs`)
- Albanian (`sq`)
- Estonian (`et`)
- Lithuanian (`lt`)
- Latvian (`lv`)
