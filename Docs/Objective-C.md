# Integration into an Objective-C app

If your app is written in Objective-C, then you'll need a Swift wrapper to use GetID iOS SDK 2.0.

At first, add a `.swift` file to the project. In Xcode select File > New > File, then select "Swift file". Then confirm when Xcode asks about the Bridging Header.

Add the following code to this file:
```swift
import GetID

@objc final class GetIDSwiftWrapper: NSObject {
    @objc func startVerificationFlow() {
        GetIDSDK.startVerificationFlow(
            apiUrl: "API_URL",
            auth: .sdkKey("SDK_KEY"),
            flowName: "FLOW_NAME"
        )
    }
}
```
Replace `API_URL`, `SDK_KEY`, and `FLOW_NAME` placeholders with the proper values.

Then call this wrapper from your Objective-C code:
```objective-c
#import "YouAppName-Swift.h"
...
GetIDSwiftWrapper *wrapper = [GetIDSwiftWrapper new];
[wrapper startVerificationFlow];
```
Replace `YouAppName-Swift.h` with the proper name; you can find it as `Objective-C Generated Interface Header Name` in Build Settings of the project.

See an example of integration into an Objective-C app [here](../ObjC-Example).