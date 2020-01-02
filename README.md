# GetID iOS SDK

## Table of contents
*   [Overview](#overview)
*   [Getting started](#getting-started)
    *   [Requirements](#requirements)
    *   [Obtaining an API key](#obtaining-an-api-key)
    *   [Camera usage description](#camera-usage-description)
    *   [Using in Objective-C apps](#using-in-objective-c-apps)
*   [Installation](#installation)
    *   [Cocoapods](#cocoapods)
    *   [Carthage](#carthage)
*   [Usage](#usage)
    *   [Possible errors](#possible-errors)
*   [Customisation](#customisation)
    *   [Flow customisation](#flow-customisation)
        *   [Changing flow content](#changing-flow-content)
        *   [Consent screen setup](#consent-screen-setup)
        *   [Form screen setup](#form-screen-setup)
        *   [Setting acceptable documents](#setting-acceptable-documents)
    *   [UI customisation](#ui-customisation)
*   [Handling callbacks](#handling-callbacks)
*   [Localisation](#localisation)

## Overview
The SDK provides a set of screens to allow capturing of identity documents and face photos. In addition, the SDK provides a possibility to add a customisable screen for users to enter text information about themselves. Finally, it uploads the captured data to GetID server.

The SDK does not provide methods for obtaining verification results. Use GetID API on your backend to get ones.

## Getting started
### Requirements
- Xcode 10.2+
- Swift 4.2+
- iOS 11+

### Obtaining an API key
In order to start using GetID SDK, you will need an API key. Use a `sandbox` key to test the integration. Use a `live` key in the production. You can get both keys inside your GetID Admin Panel.

### Camera usage description
The SDK uses the camera for capturing photos during verification. The app is responsible for describing the reason for using the camera. You must add `NSCameraUsageDescription` to the info.plist of the app.

### Using in Objective-C apps
If you app is written entirely in Objective-C, you should set `Always Embed Swift Standard Libraries` to `YES` in your app target's build settings.

## Installation

### Cocoapods

GetID SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'GetID'
```
### Carthage

GetID SDK is compatible with [Carthage](https://github.com/Carthage/Carthage). Add it to your `Cartfile`:

```ogdl
github "vvorld/getid-ios-sdk"
```

## Usage
##### Swift
```swift
import GetID
```
##### Objective-C
```Objective-C
@import GetID;
```

Use `GetIDFactory` to create an instance of `GetIDViewController`.
##### Swift
```swift
GetIDFactory.makeGetIDViewController(withApiKey: "YOUR_API_KEY", url: "YOUR_URL") { (viewController, error) in
    guard let getIDViewController = viewController else {
        return
    }
    self.present(getIDViewController, animated: true, completion: nil)
}
```
##### Objective-C
```Objective-C
[GIDFactory makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" url:@"YOUR_URL" then:^(GetIDViewController *viewController, NSError *error) {
    [self presentViewController:viewController animated:YES completion:nil];
}];
```

### Possible errors
`GetIDFactory.makeGetIDViewController` method can return an error. Here is a list of possible errors:

| Domain | Code | Description |
| ----- | ----- | ----- |
| `GetID.Auth` | 10 | Invalid URL. |
| `GetID.Auth` | 11 | You should get an AuthToken to use the SDK. |
| `GetID.Auth` | 12 | Invalid token. |
| `GetID.Configuration` | 20 | `.flowItems` should not be empty. |
| `GetID.Configuration` | 21 | `.formFields` should not be empty if `.flowItems` contains `.form`. |
| `GetID.Configuration` | 22 | None of set `.acceptableCountries` is supported. |
| `GetID.Configuration` | 23 | None of set `.acceptableDocumentTypes` is supported. |
| `GetID.Configuration` | 24 | None of intersections of set `.acceptableCountries` and `.acceptableDocumentTypes` is supported. |
| `GetID.Configuration` | 25 | `.thanks` item should be the last one. |

## Customisation

### Flow customisation
You can customise the SDK flow. Create an instance of the `Configuration` class, change its properties and pass it to  `GetIDFactory`.

| Property | Description | Default value |
| ----- | ----- | ----- |
| `flowItems` | Specifies the screens to be displayed and their order. See [paragraph](#changing-flow-content) below. | `[.document, .selfie, .thanks]` |
| `formFields` | Specifies the fields to be displayed on the form screen. See [paragraph](#form-screen-setup) below. | `[]` |
| `acceptableCountries` | Specifies a list of countries whose documents are accepted for verification. `[]` means that documents are accepted from all countries supported by GetID. See [paragraph](#setting-acceptable-documents) below. | `[]` |
| `acceptableDocumentTypes` | Specifies a list of document types accepted for verification. `[]` means that all types of documents supported by GetID are accepted. See [paragraph](#setting-acceptable-documents) below. | `[]` |

##### Swift
```swift
let configuration = Configuration()
configuration.flowItems = [.form, .selfie, .thanks]
configuration.formFields = [FormField(title: "Birth place", valueType: .country)]

GetIDFactory.makeGetIDViewController(withApiKey: "YOUR_API_KEY", url: "YOUR_URL", configuration: configuration) { (viewController, error) in
    // ...
}
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.document]];

[GIDFactory makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" url:@"YOUR_URL" configuration:configuration then:^(GetIDViewController *viewController, NSError *error) {
    // ...
}];
```

#### Changing flow content
You can specify which screens should be displayed in the verification flow and the order of them. In order to do that assign a non-empty array of `FlowItemObject` objects to `flowItems` property of `GetID.Configuration`. The possible values are `.consent`, `.form`, `.document`, `.selfie` and `.thanks`.

Note: all duplicates in `flowItems` array are ignored. So, `[.form, .form, .thanks]` is the same as `[.form, .thanks]`.
##### Swift
```swift
let configuration = Configuration()
configuration.flowItems = [.selfie, .thanks]
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.document]];
```

#### Consent screen setup
The SDK provides a customisable data-processing consent screen. By default, this screen is not displayed. If you want to display this screen then add `.consent` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section).
You can customise links and some texts on this screen. All the properties of `ConsentConfiguration` are optional. If the value of any property is `nil` then the default value is displayed.

| Property | Description |
| ----- | ----- |
| `consentText` | The text at the top of the screen. |
| `companyName` | The company name. |
| `termsOfUseURL` | The link to Terms of Use. |
| `privacyPolicyURL` | The link to Privacy Policy. |

##### Swift
```swift
let configuration = Configuration()
let consentConfiguration = ConsentConfiguration()
consentConfiguration.companyName = "Company"
configuration.consentConfiguration = consentConfiguration
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
GIDConsentConfiguration *consentConfiguration = [GIDConsentConfiguration new];
consentConfiguration.companyName = @"Company";
configuration.consentConfiguration = consentConfiguration;
```

#### Form screen setup
The SDK provides a customisable form screen. By default, this screen is not displayed. If you want to display this screen then add `.form` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section).
Also, you have to assign a non-empty array of `FormField` objects to `formFields` property of `GetID.Configuration`.

To create a `FormField` object one should pass the field title and its value type to the constructor:
##### Swift
```swift
let autorityField = FormField(title: "Authority", valueType: .text)
let birthPlaceField = FormField(title: "Birth place", valueType: .country)
```
##### Objective-C
```Objective-C
GIDFormField *authorityField = [[GIDFormField alloc] initWithTitle:@"Authority" valueType:GIDFieldValueTypeText];
GIDFormField *birthPlaceField = [[GIDFormField alloc] initWithTitle:@"Birth place" valueType:GIDFieldValueTypeCountry];
```
Supported value types: `.text`, `.date`,  `.sex` and `.country`. See the value formats for each type in the table below.

| Value type | Format |
| ----- | ----- |
| `.text` | Plain `String` |
| `.date` | Date represented as a `String` in `yyyy-MM-dd` format |
| `.sex` | `String`, `"male"` or `"female"` |
| `.country` | `String` in `ISO 3166-1 alpha-2` format |

Optionally, you can prepopulate some fields by known values. Pass the values according to formats listed in the table above. For example, you know user's first name:
##### Swift
```swift
let firstNameField = FormField(title: "First name", valueType: .text, value: "John")
```
##### Objective-C
```Objective-C
GIDFormField *authorityField = [[GIDFormField alloc] initWithTitle:@"Authority" valueType:GIDFieldValueTypeText value:@"John"];
```
There are several shortcuts for your convenience: `.makeFirstName`, `.makeLastName` and others. Titles of the fields created by these shortcuts are automatically localized. You can find all of them in `FormField`'s public header.
##### Swift
```swift
let configuration = Configuration()
configuration.flowItems = [.consent, .form]
configuration.formFields = [.makeFirstName(withValue: "John"),
                            .makeLastName(withValue: "Johnson")]
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.form]];
[configuration setFormFields:@[[GIDFormField makeFirstNameWithValue:@"John"],
                               [GIDFormField makeLastNameWithValue:@"Johnson"]]];
```
Also, if you want the user to consent to the processing of his personal data not on a separate `.consent` screen, but on the `.form` screen, then you need to set `.consentInForm` property of `GetID.Configuration` to `true`.
##### Swift
```swift
let configuration = Configuration()
configuration.consentInForm = true
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.consentInForm = YES;
```

#### Setting acceptable documents
You can limit the list of acceptable documents and issuing countries. In order to set acceptable document types one should create an instance of `Configuration` class, call `setAcceptableDocumentTypes(_:)` method of this instance passing there an array of `DocumentTypeObject` objects and then pass this configuration to `GetIDViewController` constructor. Supported document types are `.passport`, `.idCard`, `.drivingLicence`, `.residencePermit` and `.internalPassport`.

Countries are configurable in the same way, you have to call `setAcceptableCountryCodes(_:)` method and pass an array of ISO 3166-1 alpha-2 codes to it.

If GetID does not support any specified document types from any specified countries then `GetIDViewController` initializer will throw an error.
##### Swift
```swift
let configuration = Configuration()
configuration.setAcceptableDocumentTypes([.passport])
configuration.setAcceptableCountryCodes(["ru", "ee"])
GetIDFactory.makeGetIDViewController(withApiKey: "YOUR_API_KEY", url: "YOUR_URL", configuration: configuration) { (viewController, error) in
    // ...
}
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setAcceptableDocumentTypes:@[GIDDocumentType.passport]];
[configuration setAcceptableCountryCodes:@[@"ru", @"en"]];
[GIDFactory makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" url:@"YOUR_URL" configuration:configuration then:^(GetIDViewController *viewController, NSError *error) {
    // ...
}];
```
Note: this setting makes sense only if `GetIDViewController.flowItems` contains `.document`.

### UI customisation
You can customize some colors used in the SDK. Create an instance of the `Style` class, change its properties and pass it to the constructor of `GetIDViewController`.

| Property | Description |
| ----- | ----- |
| `backgroundColor` | The background color of all screens except the camera screen. |
| `tintColor` | The color of graphic elements such as guides on the camera screen and the back button. |
| `textColor` | The primary text color. |
| `placeholderColor` | The color of the placeholders on the form screen. |
| `infoTextColor` | The text color of info messages. |
| `buttonStyle.backgroundColor` | The background color of the main action button at the bottom of the screen. |
| `buttonStyle.textColor` | The text color of the main action button at the bottom of the screen. |
| `keyboardAppearance` | The appearance of the system keyboard used to fill the `Form`. |
| `activityIndicatorStyle` | The style of the activity indicator shown while sending the captured data. Possible values: `.light`, `.dark`. |
| `logoImage` | The image shown on the consent screen. |
| `tickColor` | The color of the tick symbol in checkmark views. |
| `poweredByStyle` | The style of GetID logo in `Powered by GetID` label. Possible values: `.light`, `.dark`. |

##### Swift
```swift
let style = Style()
style.backgroundColor = .lightGray
let buttonStyle = ButtonStyle()
buttonStyle.backgroundColor = .purple
style.buttonStyle = buttonStyle

GetIDFactory.makeGetIDViewController(withApiKey: "YOUR_API_KEY", url: "YOUR_URL", style: style) { (viewController, error) in
    // ...
}
```
##### Objective-C
```Objective-C
GIDStyle *style = [GIDStyle new];
style.tintColor = [UIColor purpleColor];
GIDButtonStyle *buttonStyle = [GIDButtonStyle new];
buttonStyle.textColor = [UIColor blackColor];
style.buttonStyle = buttonStyle;

[GIDFactory makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" url:@"YOUR_URL" style:style then:^(GetIDViewController *viewController, NSError *error) {
    // ...
}];
```

## Handling callbacks
There are multiple callbacks you can get from `GetIDViewController`.
If you want to handle the verification process completion then assign an object that conforms to `GetIDCompletionDelegate` protocol to `delegate` property of `GetIDViewController`. 
If you want to receive the captured data then assign an object that conforms to `GetIDCapturedDataDelegate` protocol to `capturedDataDelegate` property of `GetIDViewController`. 
If you want to handle intermediate events then assign an object that conforms to `GetIDIntermediateEventsDelegate` protocol to `intermediateEventsDelegate` property of `GetIDViewController`. 
See description of all the methods of these protocols in the tables below.

##### Swift
```swift
GetIDFactory.makeGetIDViewController(withApiKey: "YOUR_API_KEY", url: "YOUR_URL") { (viewController, error) in
    guard let getIDViewController = viewController else {
        return
    }
    getIDViewController.delegate = self
    getIDViewController.capturedDataDelegate = self
    getIDViewController.intermediateEventsDelegate = self
    self.present(getIDViewController, animated: true, completion: nil)
}

```
##### Objective-C
```Objective-C
[GIDFactory makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" url:@"YOUR_URL" then:^(GetIDViewController *viewController, NSError *error) {
    viewController.delegate = self;
    viewController.capturedDataDelegate = self;
    viewController.intermediateEventsDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}];
```

| `GetIDCompletionDelegate` method | Description |
| ----- | ----- |
| `getIDDidComplete(_:)` | Tells the delegate that the user has completed the verification process and `GetIDViewController` has been dismissed. |
| `getIDDidCancel(_:)` | Tells the delegate that the user has interrupted the verification process and `GetIDViewController` has been dismissed. |

| `GetIDCapturedDataDelegate` method | Description |
| ----- | ----- |
| `getID(_:didSubmitForm:)` | Tells the delegate that the user has filled out the form and tapped the “Next” button on the form screen. |
| `getID(_:didCaptureDocument:)` | Tells the delegate that photos of the user's document have been taken. |
| `getID(_:didTakeSelfie:)` | Tells the delegate that a photo of the user's face was taken. |

| `GetIDIntermediateEventsDelegate` method | Description |
| ----- | ----- |
| `getIDDidGetConsent(_:)` | Tells the delegate that the user has consented to the processing of his personal data. |
| `getID(_:didChooseDocumentType:issuingCountry:)` | Tells the delegate that the type of document and country of issue have been chosen. |
| `getIDDidUploadData(_:)` | Tells the delegate that the user data has been uploaded to GetID server. |

Note: some of these callbacks can be called multiple times because a user can press back button, edit the data and go forward again.

## Localisation

GetID iOS SDK contains translations for the following locales:
 - English
 - Russian

If you need translations for some other locales we don't provide yet, please contact us through [support@getid.ee](mailto:support@getid.ee).
