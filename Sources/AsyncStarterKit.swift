//
//  AsyncStarterKit.swift
//  AsyncStarterKit
//
//  Created by Joao Nunes on 01/06/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

//MARK: - ObjectMapper Promises -

public enum MapperError:ErrorType {
	case ObjectCouldNotBeCreated
}

public extension Mapper {
	
	public func fromObject(json:AnyObject) -> Promise<N> {
		return Promise()
			.thenInBackground { () -> N in
				if let object = self.map(json) {
					return object
				} else {
					throw MapperError.ObjectCouldNotBeCreated
				}
		}
	}
	
	public func fromArray(json:AnyObject) -> Promise<[N]> {
		return Promise()
			.thenInBackground { () -> [N] in
				if let object = self.mapArray(json) {
					return object
				} else {
					throw MapperError.ObjectCouldNotBeCreated
				}
		}
	}
	
}

public extension Mapper {
	
	public func toObject(object:N) -> Promise<[String:AnyObject]> {
		return Promise().thenInBackground { self.toJSON(object) }
	}
	
	public func toArray(object:[N]) -> Promise<[[String : AnyObject]]> {
		return Promise().thenInBackground { self.toJSONArray(object) }
	}
	
}

//MARK: - NSJSONSerialization Promises -

public extension NSJSONSerialization {
	
	public class func toObject(data:NSData) -> Promise<AnyObject> {
		do {
			let object:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
			return Promise<AnyObject>(object)
		} catch (let error) {
			return Promise<AnyObject>(error: error)
		}
	}
	
	public class func toData(obj: [[String:AnyObject]]) -> Promise<NSData> {
		do {
			let data:NSData = try NSJSONSerialization.dataWithJSONObject(obj, options: .PrettyPrinted)
			return Promise<NSData>(data)
		} catch (let error) {
			return Promise<NSData>(error: error)
		}
	}
	
	public class func toData(obj: [String:AnyObject]) -> Promise<NSData> {
		do {
			let data:NSData = try NSJSONSerialization.dataWithJSONObject(obj, options: .PrettyPrinted)
			return Promise<NSData>(data)
		} catch (let error) {
			return Promise<NSData>(error: error)
		}
	}
}

//MARK: - Requests Promises -

public enum NSURLSessionError:ErrorType {
	case NoData
	case BadURL
}

enum HTTPMethod:String {
	case GET
	case POST
	case PUT
	case DELETE
}


public extension NSURLSession {
	
	func GET<T:Mappable>(url: String) -> Promise<T> {
		return Promise()
			.thenInBackground { self.dataTaskPromise(url, method: .GET, body: nil) }
			.thenInBackground ( NSJSONSerialization.toObject )
			.thenInBackground ( Mapper<T>().fromObject )
	}
	
	func GET<T:Mappable>(url: String) -> Promise<[T]> {
		return Promise()
			.thenInBackground { self.dataTaskPromise(url, method: .GET, body: nil) }
			.thenInBackground ( NSJSONSerialization.toObject )
			.thenInBackground ( Mapper<T>().fromArray )
	}
	
	func POST<U:Mappable>(url: String, body:U) -> Promise<()> {
		return Promise(body)
			.thenInBackground ( Mapper().toJSON )
			.thenInBackground ( NSJSONSerialization.toData )
			.thenInBackground { self.dataTaskPromise(url, method: .POST, body: $0) }
			.thenInBackground { _ in () }
	}
	
	func POST<T:Mappable,U:Mappable>(url: String, body:U) -> Promise<T> {
		return Promise(body)
			.thenInBackground ( Mapper().toObject )
			.thenInBackground ( NSJSONSerialization.toData )
			.thenInBackground { self.dataTaskPromise(url, method: .POST, body: $0) }
			.thenInBackground ( NSJSONSerialization.toObject )
			.thenInBackground ( Mapper<T>().fromObject )
	}
	
	func POST<T:Mappable,U:Mappable>(url: String, body:[U]) -> Promise<T> {
		return Promise(body)
			.thenInBackground ( Mapper().toArray )
			.thenInBackground ( NSJSONSerialization.toData )
			.thenInBackground { self.dataTaskPromise(url, method: .POST, body: $0) }
			.thenInBackground ( NSJSONSerialization.toObject )
			.thenInBackground ( Mapper<T>().fromObject )
	}
	
	func POST<T:Mappable,U:Mappable>(url: String, body:U) -> Promise<[T]> {
		return Promise(body)
			.thenInBackground ( Mapper().toObject )
			.thenInBackground ( NSJSONSerialization.toData )
			.thenInBackground { self.dataTaskPromise(url, method: .POST, body: $0) }
			.thenInBackground ( NSJSONSerialization.toObject )
			.thenInBackground ( Mapper<T>().fromArray )
	}
	
	
	// MARK: base
	internal func dataTaskPromise(url:String, method:HTTPMethod, body:NSData?) -> Promise<NSData> {
		
		if let validUrl = NSURL(string: url) {
			return dataTaskPromise(validUrl,method: method,body: body)
		} else {
			return Promise(error: NSURLSessionError.BadURL)
		}
	}
	
	internal func dataTaskPromise(url:NSURL, method:HTTPMethod, body:NSData?) -> Promise<NSData> {
		
			let request = NSMutableURLRequest(URL: url)
			request.HTTPMethod = method.rawValue
			if body != nil {
				request.HTTPBody = body
				request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
			}
			
			return dataTaskPromise(request)
	}
	
	func dataTaskPromise(request:NSURLRequest) -> Promise<NSData> {
		let (promise,fulfill, reject) = Promise<NSData>.pendingPromise()
		
		dataTaskWithRequest(request) { (data, response, error) in
			
			if let data = data {
				fulfill(data)
			} else if let error = error {
				reject(error)
			} else {
				reject(NSURLSessionError.NoData)
			}
		}.resume()
		
		return promise
	}

}

