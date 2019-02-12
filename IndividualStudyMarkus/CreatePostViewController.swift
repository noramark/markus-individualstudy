//
//  CreatePostViewController.swift
//  IndividualStudyMarkus
//
//  Created by Eleanor Markus-19 on 1/17/19.
//  Copyright © 2019 Eleanor Markus-19. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseStorage
import FirebaseDatabase

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var image:UIImage?
    private let placeHolderText = "Write a caption ..."
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textColor = .gray
            textView.text = placeHolderText
            textView.selectedRange = NSRange()
        }
    }
    
    let picker = UIImagePickerController()
    var userStorage: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
    }
    
    @IBAction func selectImage(_sender: Any){
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postImage(_sender: Any) {
        
    }
    
    @objc func createPost() {
        
//       guard let image = self.image else {
//            return
//        }
//        //placeHolderText is written as placeholder in text book --> might have to be changed
//       let description = (textView.text != placeHolderText ? textView.text : "") ?? ""
//        var post = PostModel(photoURL: "https://d3icht40s6fxmd.cloudfront.net/sites/default/files/test-product-test.png", description: description, author: DataManager.shared.userUID ?? "no user id", width: 150, height: 150)
//        DataManager.shared.createPost(post: post, image: image, progress: { (progress) in
//            print("Upload \(progress)")
//        }) { (success) in
//            if success {
//                print("Successful upload")
//            }
//            else {
//                print("unable to create post")
//            }
//        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        //move cursor to beginning on first tap
        if textView.text == placeHolderText {
            textView.selectedRange = NSRange()
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeHolderText && !text.isEmpty {
            textView.text = nil
            textView.textColor = .black
            textView.selectedRange = NSRange()
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.selectedRange = NSRange()
        }
    }
}

/*
import UIKit
//import Firebase
import FirebaseUI
import YPImagePicker

class CreatPostViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {return true}
    private let placeholderText = "Write a caption ..."
    public var image: UIImageView?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textColor = .gray
            textView.text = placeholderText
            textView.selectedRange = NSRange()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        photo.image = image
        navigationItem.rightBarButtonItem = UIBarButtonItem (title: "Share", style: .done, target: self, action: #selector(createPost))
    }
    @objc func createPost() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
*/
