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

//MARK: ObjectMapper Promises

extension Mapper {
	
	func mapObject(json:AnyObject?) -> Promise<N?> {
		return Promise().thenInBackground { self.map(json) }
	}
	
	func mapArray(json:AnyObject?) -> Promise<[N]?> {
		return Promise().thenInBackground { self.mapArray(json) }
	}
	
}

extension Mapper {
	
	func toDictionary(object:N) -> Promise<[String:AnyObject]> {
		return Promise().thenInBackground { self.toJSON(object) }
	}
	
	func toArray(object:N) -> Promise<[AnyObject]> {
		return Promise().thenInBackground { self.toArray(object) }
	}
	
}