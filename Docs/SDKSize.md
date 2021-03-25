# SDK size

The size of SDK depends on the deployment target of your app and on the device type. To measure it, one can measure the size of an empty app with GetID iOS SDK installed. See how to do create the App Size Report [here](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size).

Here is the summary of App Size Report for [SwiftUI-Example app](../SwiftUI-Example):
```
iPhone, iOS 13.0+: 1 MB compressed, 2,5 MB uncompressed
iPad, iOS 13.0+: 973 KB compressed, 2,4 MB uncompressed
Universal, iOS 13.0+: 2 MB compressed, 3,5 MB uncompressed
```

And here is the summary of App Size Report for [Swift-Example app](../Swift-Example):
```
iPhone, iOS 11.0+: 3,5 MB compressed, 10,2 MB uncompressed
iPad, iOS 11.0+: 3,5 MB compressed, 10,2 MB uncompressed
iPhone, iOS 12.2+: 1 MB compressed, 2,5 MB uncompressed
iPad, iOS 12.2+: 965 KB compressed, 2,4 MB uncompressed
Universal, iOS 11.0+: 4,5 MB compressed, 11,3 MB uncompressed
```

The uncompressed size is equivalent to the size of the installed app on the device, and the compressed size is the download size of your app.

The size of Swift-Example app is much bigger for iOS 11.0-12.1 than for iOS 12.2+ because of the bundled Swift runtime. See more details on Swift ABI stability [here](https://swift.org/blog/abi-stability-and-apple).