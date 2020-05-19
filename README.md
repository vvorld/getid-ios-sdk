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
        *   [Video screen setup](#video-screen-setup)
        *   [Thanks screen setup](#thanks-screen-setup)
    *   [UI customisation](#ui-customisation)
    *   [Verification types](#verification-types)
*   [Linking user with verification](#linking-user-with-verification)
*   [Handling callbacks](#handling-callbacks)
*   [Video recording](#video-recording)
*   [Form prefill](#form-prefill)
*   [Localisation](#localisation)

## Overview
The SDK provides a set of screens to allow capturing of identity documents and face photos. In addition, the SDK provides a possibility to add a customisable screen for users to enter text information about themselves. Finally, it uploads the captured data to GetID server.

The SDK does not provide methods for obtaining verification results. Use GetID API on your backend to get ones.

## Getting started
### Requirements
- Xcode 10.2+
- Swift 5.0+
- iOS 11+

### Obtaining an API key
In order to start using GetID SDK, you will need an API key. Use a `sandbox` key to test the integration. Use a `live` key in the production. You can get both keys inside your GetID Admin Panel.

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
| `GetID.Auth` | 11 | You should get an AuthToken to use the SDK. |
| `GetID.Auth` | 12 | Invalid token. |
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
| `acceptableCountries` | Specifies a list of countries whose documents are accepted for verification. `[]` means that documents are accepted from all countries supported by GetID. See [paragraph](#setting-acceptable-documents) below. | `[]` |
| `acceptableDocumentTypes` | Specifies a list of document types accepted for verification. `[]` means that all types of documents supported by GetID are accepted. See [paragraph](#setting-acceptable-documents) below. | `[]` |

##### Swift
```swift
let configuration = Configuration()
configuration.setFlowItems([.form, .selfie, .thanks])
configuration.formFields = [FormField(title: "Birth place", valueType: .country)]

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
configuration.formFields = [.firstName, .lastName]
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
configuration.formFields =
    [.makeTextField(title: "Number", validator: TextFieldValidator { $0.allSatisfy { $0.isNumber } }),
     .makeTextField(title: "City", validator: .init(invalidValueMessage: "Should contain letters only") { $0.allSatisfy { $0.isLetter } })]
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
configuration.formFields =
    [.makeDateField(title: "Date of expiry", range: .future),
     .makeDateField(title: "Date", range: .init(minDate: minDate, maxDate: maxDate))]
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

## Form prefill

The SDK provides the ability to prefill the form using a captured photo of a document. 
For now, it works only for documents that contain MRZ (machine-readable zone) - almost all passports, ID cards and Residence Permit cards.
To enable this feature, one should set `prifillForm` value of `Configuration` object to `true`. And, obviously, `.document` step should preceed `.form` step.

There are two different technologies that SDK uses for text recognition - Apple's Vision and Tesseract. Vision is the default option. It doesn't increase the size of SDK (because of using a system framework) but works little bit worse than Tesseract. And Vision-based option works only for iOS 13+ users.

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
