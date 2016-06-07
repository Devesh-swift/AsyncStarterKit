//
//  ViewController.swift
//  AsyncStarterKit
//
//  Created by Joao Nunes on 01/06/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var textView: UITextView!

	var service = PostsService()
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}


	@IBAction func get(sender: AnyObject) {
		
		service.getAllPosts().then {
			(posts) -> Void in
			self.textView.text = posts.first?.body
		}
	}
	
	
	@IBAction func post(sender: AnyObject) {
		
		let post = Post()
		post.title = "test"
		
		service.createPost(post).then {
			post -> Void in
			self.textView.text = "Posted: \(post.title)"
		}
		
	}

}

