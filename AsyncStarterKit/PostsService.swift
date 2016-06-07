//
//  PostsService.swift
//  AsyncStarterKit
//
//  Created by Joao Nunes on 07/06/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import PromiseKit

class PostsService {
	
	
	func getAllPosts() -> Promise<[Post]> {
		let url = "http://jsonplaceholder.typicode.com/posts"
		
		return NSURLSession.sharedSession().GET(url)
		
	}
	
	func createPost(post:Post) -> Promise<Post> {
		let url = "http://jsonplaceholder.typicode.com/posts"
		
		return NSURLSession.sharedSession().POST(url, body: post)
	}
}