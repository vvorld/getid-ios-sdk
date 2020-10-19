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
        *   [Animated guides](#animated-guides)
        *   [Interactive document step](#interactive-document-step)
        *   [Form screen setup](#form-screen-setup)
        *   [Setting acceptable documents](#setting-acceptable-documents)
        *   [Video screen setup](#video-screen-setup)
        *   [Thanks screen setup](#thanks-screen-setup)
    *   [UI customisation](#ui-customisation)
    *   [Verification types](#verification-types)
*   [Linking user with verification](#linking-user-with-verification)
*   [Handling callbacks](#handling-callbacks)
*   [Video recording](#video-recording)
*   [NFC reading](#nfc-reading)
*   [Form prefill](#form-prefill)
*   [Localisation](#localisation)
*   [Troubleshooting](#troubleshooting)

## Overview
The SDK provides a set of screens to allow capturing of identity documents and face photos. In addition, the SDK provides a possibility to add a customisable screen for users to enter text information about themselves. Finally, it uploads the captured data to GetID server.

The SDK does not provide methods for obtaining verification results. Use GetID API on your backend to get ones.

## Getting started
### Requirements
- Xcode 10.2+
- Swift 5.0+
- iOS 11+

### Obtaining an API key
In order to start using GetID SDK, you need an API key and API url. In your GetID Dashboard, you can get and set `API key` and `SDK key`. `API key` grants you access to public API calls and SDK API calls. `SDK key` grants you access to SDK API calls only. For security reasons, strongly recommended using the `SDK key` in your SDK.

### Camera usage description
The SDK uses the camera for capturing photos during verification. The app is responsible for describing the reason for using the camera. You must add `NSCameraUsageDescription` to the Info.plist of the app.

### Using in Objective-C apps
If you app is written entirely in Objective-C, you should set `Always Embed Swift Standard Libraries` to `YES` in your app target's build settings.

## Installation

### Cocoapods

GetID SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'GetID'
```
Note: in case of `Unable to find a specification for 'GetID'` error, try `pod repo update` and then `pod install` again.

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
GetIDFactory.makeGetIDViewController(apiKey: "YOUR_API_KEY", url: "YOUR_URL") { (viewController, error) in
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
| `GetID.Auth` | 13 | SDK version is not supported. Please, update GetID SDK (or try to use another GetID server). |
| `GetID.Auth` | 14 | Invalid key provided. |
| `GetID.Configuration` | 20 | `.flowItems` should not be empty. |
| `GetID.Configuration` | 21 | `.formFields` should not be empty if `.flowItems` contains `.form`. |
| `GetID.Configuration` | 22 | None of set `.acceptableCountries` is supported. |
| `GetID.Configuration` | 23 | None of set `.acceptableDocumentTypes` is supported. |
| `GetID.Configuration` | 24 | None of intersections of set `.acceptableCountries` and `.acceptableDocumentTypes` is supported. |
| `GetID.Configuration` | 25 | `.thanks` item should be the last one. |
| `GetID.Configuration` | 26 | `.form` can not be the only flow item if all fields are hidden. |
| `GetID.Configuration` | 27 | `.flowItems` should contain `.selfie` and `.document` if `.verificationTypes` contains `.faceMatching`. |
| `GetID.Configuration` | 28 | `.flowItems` should contain `.document` if `.verificationTypes` contains `.dataExtraction`. |
| `GetID.Configuration` | 29 | `.flowItems` should contain `.document` or `.formFields` should contain `.firstName`, `.lastName` and `.dateOfBirth` if `.verificationTypes` contains `.watchlists`. |
| `GetID.Configuration` | 30 | `recordSelfieVideo` should be `false` if `.flowItems` contains `.video`. |

## Customisation

### Flow customisation
You can customise the SDK flow. Create an instance of the `Configuration` class, change its properties and pass it to  `GetIDFactory`.

| Property | Description | Default value |
| ----- | ----- | ----- |
| `flowItems` | Specifies the screens to be displayed and their order. See [paragraph](#changing-flow-content) below. | `[.document, .selfie, .thanks]` |
| `formFields` | Specifies the fields to be displayed on the form screen. See [paragraph](#form-screen-setup) below. | `[]` |
| `multiScreenForm` | Allows to create a multi-screen form step. If non-empty then `formFields` property is ignored. See [paragraph](#form-screen-setup) below. | `[]` |
| `consentInForm` | A flag that determines whether to display the data-processing consent checkbox on the form screen. | `false` |
| `prefillForm` | A flag that determines whether to prefill form with values extracted from the document. See [paragraph](#form-prefill) below. | `false` |
| `interactiveDocumentStep` | A flag that determines whether the `.document` step should be "interactive". See [paragraph](#interactive-document-step) below. | `false` |
| `useNFC` | A flag that determines whether to use NFC for data extraction from the document. See [paragraph](#nfc-reading) below. | `false` |
| `allowDocumentPhotosFromGallery` | A flag that determines whether to use the photo gallery as a document images' source. | `false` |
| `acceptableCountries` | Specifies a list of countries whose documents are accepted for verification. `[]` means that documents are accepted from all countries supported by GetID. See [paragraph](#setting-acceptable-documents) below. | `[]` |
| `acceptableDocumentTypes` | Specifies a list of document types accepted for verification. `[]` means that all types of documents supported by GetID are accepted. See [paragraph](#setting-acceptable-documents) below. | `[]` |
| `recordSelfieVideo` | A flag that determines whether to record video while the user is taking selfie. See [paragraph](#video-recording) below. | `false` |

##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.form, .selfie, .thanks])
configuration.setFormFields([FormField(title: "Birth place", valueType: .country)])

GetIDFactory.makeGetIDViewController(apiKey: "YOUR_API_KEY", url: "YOUR_URL", configuration: configuration) { (viewController, error) in
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
You can specify which screens should be displayed in the verification flow and the order of them. In order to do that assign a non-empty array of `FlowItemObject` objects to `flowItems` property of `GetID.Configuration`. The possible values are `.consent`, `.form`, `.document`, `.selfie`, `.video` and `.thanks`.

Note: all duplicates in `flowItems` array are ignored. So, `[.form, .form, .thanks]` is the same as `[.form, .thanks]`.
##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.selfie, .thanks])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.document]];
```

#### Consent screen setup
The SDK provides a customisable data-processing consent screen. By default, this screen is not displayed. If you want to display this screen then add `.consent` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section).
You can customise links and some texts on this screen. See the properties of `ConsentConfiguration` in the table below.

| Property | Description |
| ----- | ----- |
| `consentText` | The text at the top of the screen. |
| `companyName` | The company name. |
| `termsOfUseURL` | The link to Terms of Use. |
| `privacyPolicyURL` | The link to Privacy Policy. |

##### Swift
```swift
let configuration = Configuration()
let consentConfiguration = Configuration.ConsentConfiguration()
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

#### Animated guides
The SDK can display animated guides that explain how to photograph a document and to take a selfie so that verification is more likely to succeed. The guides for `document` and `selfie` steps can be enabled separately.

##### Swift
```swift
let configuration = Configuration()
configuration.displayGuideAtDocumentStep = true
configuration.displayGuideAtSelfieStep = true
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.displayGuideAtDocumentStep = YES;
configuration.displayGuideAtSelfieStep = YES;
```

#### Interactive document step
You can make `.document` step "interactive". In this case, the screen where the user picks the document type and the issuing country won't be displayed. Instead, the SDK will ask the user to provide a photo of a document. Then the photo will be validated and if we need another side's photo then the SDK will ask the user to take a photo of the other side. And the SDK won't allow the user to pass further if the photo does not contain a document or the quality of the photo is poor. In such cases, the user has to retake the photo.

In short, `.interactiveDocumentStep` increases the quality of the photos of documents that are sent to the verification. We recommend enabling this flag.

Also, if this feature is enabled, the [form prefill](#form-prefill) feature works for all the supported documents (not only for documents with MRZ).

##### Swift
```swift
let configuration = Configuration()
configuration.interactiveDocumentStep = true
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.interactiveDocumentStep = YES;
```

Note: `.acceptableCountries` and `.acceptableDocumentTypes` settings are ignored if `.interactiveDocumentStep` is enabled.

#### Form screen setup
The SDK provides a customisable form screen. By default, this screen is not displayed. If you want to display this screen then add `.form` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section).
Also, you have to assign a non-empty array of `FormField` objects to `formFields` property of `GetID.Configuration`.
##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.form])
configuration.setFormFields([.firstName, .lastName])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.form]];
[configuration setFormFields:@[[GIDFormField makeFirstNameWithValue:@"John"],
                               [GIDFormField makeLastNameWithValue:@"Johnson"]]];
```

Alternatively, you can create a multi-screen form.
##### Swift
```swift
let configuration = Configuration()
configuration.multiScreenForm = [FormScreen(title: "Screen 1", fields: [.firstName, .lastName]), 
                                 FormScreen(title: "Screen 2", fields: [.email])]
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.multiScreenForm = @[[[GIDFormScreen alloc] initWithTitle:@"Screen 1" fields:@[GIDFormField.firstName]], 
                                  [[GIDFormScreen alloc] initWithTitle:@"Screen 2" fields:@[GIDFormField.email]]];
```

And you can ask users to attach some files to the form:
##### Swift
```swift
let configuration = Configuration()
configuration.multiScreenForm = [FormScreen(title: "Personal data", 
                                            fields: [.firstName, .lastName], 
                                            fileAttachments: [FileAttachment(title: "Proof of address")])]
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.multiScreenForm = @[[[GIDFormScreen alloc] 
                                    initWithTitle:@"Personal data" 
                                    fields:@[GIDFormField.firstName] 
                                    fileAttachments:@[[[GIDFileAttachment alloc] initWithTitle:@"Proof of address"]]]];
```

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

Note: all duplicates (fields with same titles) in `formFields` array are ignored. So, `[.init(title: "City", valueType: .text), .init(title: "City", valueType: .text)]` is the same as `[.init(title: "City", valueType: .text)]`.

Optionally, you can prepopulate some fields by known values. Pass the values according to formats listed in the table above. For example, you know user's first name:
##### Swift
```swift
let firstNameField = FormField(title: "First name", valueType: .text, value: "John")
```
##### Objective-C
```Objective-C
GIDFormField *authorityField = [[GIDFormField alloc] initWithTitle:@"Authority" valueType:GIDFieldValueTypeText value:@"John"];
```
There are several shortcuts for your convenience: `.firstName`, `.lastName` and others. Titles of the fields created by these shortcuts are automatically localized. You can find all of them in `FormField`'s public header.
##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.consent, .form])
configuration.setFormFields([.firstName, .lastName])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.form]];
[configuration setFormFields:@[[GIDFormField makeFirstNameWithValue:@"John"],
                               [GIDFormField makeLastNameWithValue:@"Johnson"]]];
```

Also, you can create fields with a finite set of possible values. In this case, users will choose a value using a picker, instead of typing it. The `valueType` of such fields is `.text`.
##### Swift
```swift
let field = FormField(title: "City", possibleValues: ["Tallinn", "Tartu"])
```
##### Objective-C
```Objective-C
GIDFormField *field = [[GIDFormField alloc] initWithTitle:@"City" possibleValues:@[@"Tallinn", @"Tartu"]];
```

You can pass validators to `.text` fields. In order to do that, create an instance of `TextFieldValidator` type. Its initializer accepts a validation closure and, optionally, a message that will be shown to the user if the input is invalid.
##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.form, .thanks])
configuration.setFormFields(
    [.makeTextField(title: "Number", validator: TextFieldValidator { $0.allSatisfy { $0.isNumber } }),
     .makeTextField(title: "City", validator: .init(invalidValueMessage: "Should contain letters only") { $0.allSatisfy { $0.isLetter } })])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.form]];
GIDTextFieldValidator *validator = [[GIDTextFieldValidator alloc] initWithClosure:^BOOL(NSString * _Nonnull string) {
    return [string integerValue];
}];
[configuration setFormFields:@[[GIDFormField makeTextFieldWithTitle:@"Number" validator:validator]]];
```

You can pass ranges to `.date` fields. Create `DateFieldRange` object, passing `minDate` and `maxDate` (or only one of them) to its initializer or use predefined ranges like `.past` and `.future`. 
##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.form, .thanks])
configuration.setFormFields(
    [.makeDateField(title: "Date of expiry", range: .future),
     .makeDateField(title: "Date", range: .init(minDate: minDate, maxDate: maxDate))])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.consent, GIDFlowItemObject.form]];
[configuration setFormFields:@[[GIDFormField makeDateFieldWithTitle:@"Date of issue" range:[GIDDateFieldRange past]]]];
```

Also, you can create optional fields. Users will be able to skip them.
##### Swift
```swift
let fields: [FormField] = 
    [FormField(title: "City", possibleValues: ["Tallinn", "Tartu"], optional: true),
     FormField(title: "Address", valueType: .text, value: nil, optional: true),
     .makeTextField(title: "Number", validator: .init { Int($0) != nil }, optional: true)]
```
##### Objective-C
```Objective-C
GIDFormField *field = [[GIDFormField alloc] initWithTitle:@"City" possibleValues:@[@"Tallinn", @"Tartu"] optional:YES];
```

If you have some information about the user that you want to verify using GetID, but you do not want to allow the user to edit this info, you can create hidden fields.
##### Swift
```swift
let hiddenField = FormField(title: "Last name", valueType: .text, value: "Johnson", hidden: true)
```
##### Objective-C
```Objective-C
GIDFormField *hiddenField = [[GIDFormField alloc] initWithTitle:@"Last name" valueType:GIDFieldValueTypeText value:@"Johnson" hidden:YES];
```
Note: if all the fields are hidden then `.form` step is skipped.

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
GetIDFactory.makeGetIDViewController(apiKey: "YOUR_API_KEY", url: "YOUR_URL", configuration: configuration) { (viewController, error) in
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

#### Video screen setup
The SDK provides a customisable screen for recording a video with a user saying a phrase.
By default, this screen is not displayed. If you want to display this screen then add `.video` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section). 
Also, you have to provide the instructions to the user (a phrase he/she should say). And you can set the limit of the video length.
Finally, you must add `NSMicrophoneUsageDescription` to the Info.plist of the app.

##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.document, .selfie, .video, .thanks])
let videoConfiguration = Configuration.VideoFlowItemConfiguration()
videoConfiguration.instructions = "Hello, my name is ..."
videoConfiguration.durationLimit = 20
configuration.videoFlowItemConfiguration = videoConfiguration
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setFlowItems:@[GIDFlowItemObject.document, GIDFlowItemObject.selfie, GIDFlowItemObject.video]];
GIDThanksConfiguration *videoConfiguration = [GIDVideoFlowItemConfiguration new];
videoConfiguration.instructions = @"Hello, my name is ...";
configuration.videoFlowItemConfiguration = videoConfiguration;
```

Note: this feature can be not included in your tariff plan. In this case, `.video` in `.flowItems` is ignored.

#### Thanks screen setup
The SDK provides a customisable "Thank you" screen. If you want to display this screen then add `.thanks` value to `flowItems` property of `GetID.Configuration` (see [Changing flow content](#changing-flow-content) section).
You can customise texts on this screen. See the properties of `ThanksConfiguration` in the table below.

| Property | Description |
| ----- | ----- |
| `title` | The title of the screen. |
| `detailsText` | The secondary text below the title. |
| `buttonTitle` | The button title. |

##### Swift
```swift
let configuration = Configuration()
let thanksConfiguration = Configuration.ThanksConfiguration()
thanksConfiguration.title = "Congratulations!"
configuration.thanksConfiguration = thanksConfiguration
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
GIDThanksConfiguration *thanksConfiguration = [GIDThanksConfiguration new];
thanksConfiguration.title = @"Congratulations!";
configuration.thanksConfiguration = thanksConfiguration;
```

### UI customisation
You can customize some colors used in the SDK. Create an instance of the `Style` class, change its properties and pass it to the constructor of `GetIDViewController`.

| Property | Description |
| ----- | ----- |
| `backgroundColor` | The background color of all the screens. |
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
| `invalidValueColor` | The color of invalid field values highlighting on the form screen. |
| `cameraScreenBackgroundColor` | The background color of the camera screen. If `nil` then `.backgroundColor` is used. |
| `poweredByStyle` | The style of GetID logo in `Powered by GetID` label. Possible values: `.light`, `.dark`. |
| `successIconStyle` | The style of the icon used to display a successful result. |
| `errorIconStyle` | The style of the icon used in error message alerts. |
| `cautionIconStyle` | The style of the icon used in warnings. |

##### Swift
```swift
let style = Style()
style.backgroundColor = .lightGray
let buttonStyle = Style.ButtonStyle()
buttonStyle.backgroundColor = .purple
style.buttonStyle = buttonStyle

GetIDFactory.makeGetIDViewController(apiKey: "YOUR_API_KEY", url: "YOUR_URL", style: style) { (viewController, error) in
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

### Verification types
You may also set desirable types of verification. In order to do that pass a non-empty array of `VerificationTypeObject` objects to `setVerificationTypes(_:)` method of `GetID.Configuration`. The possible values are `.faceMatching`, `.dataExtraction` and `.watchlists`.

##### Swift
```swift
let configuration = Configuration()
configuration.setVerificationTypes([.faceMatching, .watchlists])
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
[configuration setVerificationTypes:@[GIDVerificationType.faceMatching, GIDVerificationType.dataExtraction]];
```

Note:  if you set `verificationTypes`, then make sure that `.flowItems` contains required steps, otherwise, you'll get an error instead of `GetIDViewController` instance. For example, `.dataExtraction` requires `.document` step in `.flowItems`.

## Linking user with verification

You can pass `customerId` to `GetIDFactory`. This is useful if you want to link the verification with a user in your database.

##### Swift
```swift
GetIDFactory.makeGetIDViewController(
    apiKey: "YOUR_API_KEY", 
    url: "YOUR_URL", 
    configuration: .defaultConfiguration,
    style: .defaultStyle, 
    customerId: "CUSTOMER_ID", 
    textRecognizer: nil) { (viewController, error) in
    guard let getIDViewController = viewController else {
        return
    }
    self.present(getIDViewController, animated: true, completion: nil)
}
```
##### Objective-C
```Objective-C
[GIDFactory 
    makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" 
    url:@"YOUR_URL" 
    configuration:configuration
    style:style
    customerId:@"CUSTOMER_ID"
    textRecognizer:textRecognizer
    then:^(GetIDViewController *viewController, NSError *error) {
    [self presentViewController:viewController animated:YES completion:nil];
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
GetIDFactory.makeGetIDViewController(apiKey: "YOUR_API_KEY", url: "YOUR_URL") { (viewController, error) in
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
| `getIDDidComplete(_:applicationID:)` | Tells the delegate that the user has completed the verification process and `GetIDViewController` has been dismissed. |
| `getIDDidCancel(_:)` | Tells the delegate that the user has interrupted the verification process and `GetIDViewController` has been dismissed. |
| `getIDDidFail(_:)` | Tells the delegate that the verification process has been failed and `GetIDViewController` has been dismissed. This can happen, for example, if the passed `customerId` has already been used. |

| `GetIDCapturedDataDelegate` method | Description |
| ----- | ----- |
| `getID(_:didSubmitForm:)` | Tells the delegate that the user has filled out the form and tapped the “Next” button on the form screen. |
| `getID(_:didCaptureDocument:)` | Tells the delegate that photos of the user's document have been taken. |
| `getID(_:didTakeSelfie:)` | Tells the delegate that a photo of the user's face was taken. |
| `getID(_:didRecordSelfieVideo:)` | Tells the delegate that a video of the user's face was recorded. |

| `GetIDIntermediateEventsDelegate` method | Description |
| ----- | ----- |
| `getIDDidGetConsent(_:)` | Tells the delegate that the user has consented to the processing of his personal data. |
| `getID(_:didChooseDocumentType:issuingCountry:)` | Tells the delegate that the type of document and country of issue have been chosen. |
| `getIDDidUploadData(_:)` | Tells the delegate that the user data has been uploaded to GetID server. |

Note: some of these callbacks can be called multiple times because a user can press back button, edit the data and go forward again.

##  Video recording
The SDK provides the ability to record a video of selfie taking process. The video can be used to verify liveness of the user. 

Please do not confuse video recording while taking a selfie with a separate `.video` step.
These two features are mutually excluded, you can not enable them both simultaneously.
The description of `.video` step see in [this section](#video-screen-setup).

Video recording starts when the selfie screen appears and stops when the user takes a selfie. The duration of the video is limited by `selfieVideoDurationLimit` value and if it exceeded then the beginning of the video is being trimmed.
In order to enable this feature one should set `recordSelfieVideo` property of `Configuration` object to `true`. And, obviously, `flowItems` should contain `.selfie` step.

Note: the valid range of `selfieVideoDurationLimit` value is `1...N` seconds, where `N` is obtained from the backend. If one set a value outside of this range then the value will be set to the nearest bound of the range.

Note: this feature can be not included in your tariff plan. In this case, `recordSelfieVideo` flag has no power.

##### Swift
```swift
let configuration = Configuration()
configuration.recordSelfieVideo = true
configuration.selfieVideoDurationLimit = 5
configuration.setFlowItems([.selfie, .thanks])
...
```
##### Objective-C
```Objective-C
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.recordSelfieVideo = YES;
configuration.selfieVideoDurationLimit = 5;
[configuration setFlowItems:@[GIDFlowItemObject.selfie, GIDFlowItemObject.thanks]];
...
```

## NFC reading
The SDK is able to read documents using NFC. This feature requires iOS 13+ and works on devices that support NFC reading. 
To enable this feature, one should set `useNFC` value of `Configuration` object to `true`. And, obviously, `flowItems` should contain `.document` step.

Also, you have to add one more line to your `Cartfile` or `Podfile`:  `github "vvorld/getid-ios-nfc"` or `pod 'GetIDNFC'` respectively. Then you should create an instance of `GetIDNFCDocumentReader` and pass it to `GetIDFactory`.

##### Swift
```swift
import GetID
import GetIDNFC
...
let configuration = Configuration()
configuration.useNFC = true
configuration.setFlowItems([.document, .form, .selfie])
...
GetIDFactory.makeGetIDViewController(
    apiKey: "YOUR_SDK_KEY",
    url: "YOUR_URL",
    configuration: configuration,
    style: .default,
    nfcReader: GetIDNFCDocumentReader()) { (viewController, error) in
    // ...
}
...
extension GetIDNFCDocumentReader: NFCReader {}
```

Note: access to a document's chip requires a key from its MRZ (machine-readable zone). To increase the chances of successful recognition of the key, one can use `GetIDOCR` framework (see [this section](#form-prefill) for more info).

Note: the SDK displays user a screen for NFC reading only if our server expects that the selected type of a document contains RFID chip. If the SDK does not display this screen for documents you sure contain a chip, please contact us through [support@getid.ee](mailto:support@getid.ee).

## Form prefill

The SDK provides the ability to prefill the form using a captured photo of a document. 
If you enable `.interactiveDocumentStep`, then this feature works for all the supported documents.
Otherwise, it works only for documents that contain MRZ (machine-readable zone) - almost all passports, ID cards and Residence Permit cards.
To enable this feature, one should set `prifillForm` value of `Configuration` object to `true`. And, obviously, `.document` step should preceed `.form` step.

There are two different technologies that SDK uses for text recognition - Apple's Vision and Tesseract. Vision is the default option. It doesn't increase the size of SDK (because of using a system framework) but works little bit worse than Tesseract. And Vision-based option works only for iOS 13+ users.

Note: if `.interactiveDocumentStep` is enabled then the OCR performed at the back-end, so you don't need to import `GetIDOCR`. 

##### Swift
```swift
// Vision-based text recognition:
let configuration = Configuration()
configuration.prefillForm = true
configuration.setFlowItems([.document, .form])
...
```
##### Objective-C
```Objective-C
// Vision-based text recognition:
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.prefillForm = YES;
[configuration setFlowItems:@[GIDFlowItemObject.document, GIDFlowItemObject.form]];
...
```

If you want to use Tesseract-based text recognition then you have to add one more line to your `Cartfile` or `Podfile`:  `github "vvorld/getid-ios-ocr"` or `pod 'GetIDOCR'` respectively. Then you should create an instance of `MRZTextRecognizer` and pass it to `GetIDFactory`.

##### Swift
```swift
// Tesseract-based text recognition:
import GetID
import GetIDOCR
...
let configuration = Configuration()
configuration.prefillForm = true
configuration.setFlowItems([.document, .form])
...
GetIDFactory.makeGetIDViewController(
    apiKey: "YOUR_API_KEY", 
    url: "YOUR_URL", 
    configuration: configuration, 
    style: .default, 
    textRecognizer: MRZTextRecognizer()) { (viewController, error) in
    // ...
}
...
extension MRZTextRecognizer: TextRecognizer {}
```
##### Objective-C
```Objective-C
// Tesseract-based text recognition:
@import GetID;
@import GetIDOCR;
...
GIDConfiguration *configuration = [GIDConfiguration new];
configuration.prefillForm = YES;
[configuration setFlowItems:@[GIDFlowItemObject.document, GIDFlowItemObject.form]];
...
[GIDFactory 
    makeGetIDViewControllerWithApiKey:@"YOUR_API_KEY" 
    url:@"YOUR_URL" 
    configuration:configuration 
    style:style 
    textRecognizer:[MRZTextRecognizer new] 
    then:^(GetIDViewController *viewController, NSError *error) {
    // ...
}];
```

## Localisation

GetID iOS SDK contains translations for the following locales:
 - English
 - Russian

If you need translations for some other locales we don't provide yet, please contact us through [support@getid.ee](mailto:support@getid.ee).

Also, you can override all the strings in the SDK, providing your own translations for any amount of locales. 

To do so, at first you need to get the list of all keys used in `.strings` files in the SDK. 
Run the following command in Terminal to convert a `.strings` file to a human-readable format:
```bash
plutil -convert xml1 /path/to/sdk/GetID.framework/en.lproj/Consent.strings -o /path/to/output/Consent.strings
```

Once you have the list of keys you want to localize, you can provide values for them in your `Localizable.strings` files, adding `GetID.TableName.` prefix to the keys:
```
// in Localizable.strings
"GetID.Consent.iAgree" = "...";
```

Or, you can create `.strings` files with the same names as in GetID SDK, just with `GetID` prefix:
```
// in GetID.Consent.strings
"iAgree" = "...";
```

## Troubleshooting

#### iOS 14 simulators issue
There is a known issue on iOS 14 simulators: `/usr/lib/libnfshared.dylib: mach-o, but not built for platform iOS-sim`. Apple forgot to add `libnfshared.dylib` for whatever reason in the final version of Xcode 12 for iOS 14 simulators. A working workaround until Apple fixes this is to copy the missing lib from Xcode 12 beta 6 over (download the beta from Apple's developer download section).
Hopefully, the issue will be fixed in Xcode 12.2.

For now, you may execute the following command to download and place it inside the Xcode package:
```bash
sudo curl https://storage.googleapis.com/mobile-simulator-build/libnfshared.dylib -o /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libnfshared.dylib
```