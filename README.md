# 📒 AlamofireLogbook
An Alamofire network activity logger view

<!--[![CI Status](https://img.shields.io/travis/mikeAttia/AlamofireLogbook.svg?style=flat)](https://travis-ci.org/mikeAttia/AlamofireLogbook)-->
[![Version](https://img.shields.io/cocoapods/v/AlamofireLogbook.svg?style=flat)](https://cocoapods.org/pods/AlamofireLogbook)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireLogbook.svg?style=flat)](https://developer.apple.com/resources/)
[![Swift Version](https://img.shields.io/badge/swift-4.1-orange.svg?style=flat)](https://swift.org/blog/swift-4-1-released/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)


## Installation

AlamofireLogbook is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AlamofireLogbook'
```


## Usage

To start logging, import the libraray in your network layer and use the method `log()` on your Alamofire `DataRequest` instance like the following example:

```swift
import Alamofire
import AlamofireLogbook

Alamofire
.request("https://httpbin.org/get")
.log()
.responseJSON { response in
// Your code
}
```

If you want to log each request yourself
1. Conform to `AlamofireResponseListener` 
2. implement 
```swift
recievedResponseFor(item : LogItem)
```
3. assign your delegate class in the app delegate to `AlamofireLogbook.shared.delegate`

OR to show the Network activity logs view just call

```swift
AlamofireLogbook.show()
```
and you'll get A full searchable log

![screenshot_01](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_01.png) ![screenshot_02](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_02.png) ![screenshot_03](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_03.png) ![screenshot_04](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_04.png)

>### 💡Tip
>Use the action button on the top right of the request details page to copy a readable formatted string of both the request and response. 😉 


## Example

To try the example project:

run `pod try AlamofireLogbook` in your ternimal

or

clone the repo, and run `pod install` from the Example directory first.


## Requirements

- iOS 9.0+
- Xcode 9+
- Swift 3.2+
- AlamofireLogbook is a plugin for [Alamofire](https://github.com/Alamofire/Alamofire) framework

## Contributions

If you have some ideas on how to improve the framework, Fork it, implement your changes and create that pull request already 😉.

All contributions are welcome 🤗.

## Author

Built with 💙 by [mikeAttia](https://github.com/mikeAttia)

## License

AlamofireLogbook is available under the MIT license. See the LICENSE file for more info.
