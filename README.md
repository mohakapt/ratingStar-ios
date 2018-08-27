# Rating Star
> A nice-looking new concept for rating bars implemented for iOS. 

[![Version](https://img.shields.io/cocoapods/v/RatingStar.svg?style=flat)](https://cocoapods.org/pods/RatingStar)
[![Platform](https://img.shields.io/cocoapods/p/RatingStar.svg?style=flat)](https://cocoapods.org/pods/RatingStar)
![API](https://img.shields.io/badge/Swift-4.0-F16D39.svg?style=flat)
[![GitHub issues](https://img.shields.io/github/issues-raw/mohakapt/ratingstar-ios.svg)](https://github.com/mohakapt/ratingstar-ios/issues)
[![License](https://img.shields.io/cocoapods/l/RatingStar.svg?style=flat)](https://cocoapods.org/pods/RatingStar)

The concept looks like a flower with every petal representing a specific rating.<br/>
*The idea of this project is originally inspired by this [concept](https://goo.gl/Yn2CCh).*
<br/><br/>

![Example](https://raw.githubusercontent.com/mohakapt/ratingstar-ios/master/Images/star.gif)

### Installation
RatingStar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'RatingStar'
```
For an Android implementation please check this [repository](https://github.com/mohakapt/ratingstar-android).


### Usage
* Please check the example in the source code for more detailed information, or check the table below for a list of available properties.
* If you want to use storyboards, just drop a UIView into your ViewController and set its class to `UIRatingStar`. Then customize is through the attributes in the inspector.
* If you don't use storyboards, you need to write a few lines of code to initialize with frame and set the properties:

```swift
import RatingStar

let starColor: UIColor = .blue
let selectionColor: UIColor = .orange

let ratingStar = UIRatingStar(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
ratingStar.value = 3
ratingStar.unselectedColor = starColor
ratingStar.selectedColor = selectionColor

self.view.addSubview(ratingStar)
```

* List of available properties:

|Property Name|Default Value|Description|
|---|---|---|
|value|0|The initial rating of the view.|
|starColor|#007AFF|The color of the star.|
|selectionColor|#FFAF00|The color of selected petals of the star.| 
|showNumbers|true|Determines weather to show numbers on the petals of the star.|

## Roadmap
The library is still not as elegant as the original concept, so I might work more on adding some animations in my spare time. (But unfortunately since I have another job, I can't give any promises or deadlines).


## Contributing
If you encounter a bug or you have a feature in mind please make a pull request and i will merge it as soon as possible, if you can't (for some reason) make a pull request please open an issue and i will happily do respond to it.


## Versioning
I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/mohakapt/ratingstar-ios/tags).<br/>
I will try to provide release notes with future releases.


## License
This project is licensed under the Apache-2.0 license - see the [LICENSE.md](https://github.com/mohakapt/ratingstar-ios/blob/master/LICENSE) file for more details.
