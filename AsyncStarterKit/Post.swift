//
//  Post.swift
//  AsyncStarterKit
//
//  Created by Joao Nunes on 07/06/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

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