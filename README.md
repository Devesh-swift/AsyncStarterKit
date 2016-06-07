# AsyncStarterKit
A starter Kit for those who want to have a quick start with PromiseKit and ObjectMapper

[![AsyncStarterKit](https://img.shields.io/cocoapods/v/AsyncStarterKit.svg)]()

Installation
============

####Manual

Copy `AsyncStarterKit.swift` to your project

####CocoaPods
```ruby
	pod 'AsyncStarterKit'
```
####Swift Package Manager
You can use [Swift Package Manager](https://swift.org/package-manager/) and specify a dependency in `Package.swift` by adding this:
```swift
.Package(url: "https://github.com/jonasman/AsyncStarterKit.git", majorVersion: 1)
```

Usage
============
```swift
import Mappable
	
class Post:Mappable {
	
	var userId:Int?
	var id:Int?
	var title:String?
	var body:String?
	
	init() { }
	required init?(_ map: Map) { }
	
	func mapping(map: Map) {
		userId	<- map["userId"]
		id		<- map["id"]
		title	<- map["title"]
		body	<- map["body"]
	}
	
}
```

```swift
	import AsyncStarterKit

	func getAllPosts() -> Promise<[Post]> {
		let url = "http://jsonplaceholder.typicode.com/posts"
		
		return NSURLSession.sharedSession().GET(url)
	}
```

Licence
============
        
The MIT License (MIT)

Copyright (c) 2014 João Nunes

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
