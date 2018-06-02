# 📒 AlamofireLogbook
An Alamofire network activity logger view

<!--[![CI Status](https://img.shields.io/travis/mikeAttia/AlamofireLogbook.svg?style=flat)](https://travis-ci.org/mikeAttia/AlamofireLogbook)-->
[![Version](https://img.shields.io/cocoapods/v/AlamofireLogbook.svg?style=flat)](https://cocoapods.org/pods/AlamofireLogbook)
[![License](https://img.shields.io/cocoapods/l/AlamofireLogbook.svg?style=flat)](https://cocoapods.org/pods/AlamofireLogbook)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireLogbook.svg?style=flat)](https://cocoapods.org/pods/AlamofireLogbook)

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

Then to show the Network activity logs view just call

```swift
AlamofireLogbook.show()
```
and you'll get the followoing view

![screenshot_01](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_01.png) ![screenshot_02](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_02.png) ![screenshot_03](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_03.png) ![screenshot_04](https://raw.githubusercontent.com/mikeAttia/AlamofireLogbook/master/Screenshots/screenshot_04.png)

####💡 Tip
Use the action button on the top right of the request details page to copy a readable formatted string of both the request and response. 😉 


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

mikeAttia, dr.mike.attia@gmail.com

## License

AlamofireLogbook is available under the MIT license. See the LICENSE file for more info.
