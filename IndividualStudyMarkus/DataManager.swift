//
//  DataManager.swift
//  IndividualStudyMarkus
//
//  Created by Eleanor Markus-19 on 1/29/19.
//  Copyright © 2019 Eleanor Markus-19. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseDatabase
import FirebaseStorage

class PostModel {
    var photoURL: String? 
    var description: String
    var author: String
    var width: Int = 0
    var height: Int = 0
    init(photoURL: String, description: String, author: String, width: Int, height: Int) {
        self.photoURL = photoURL
        self.description = description
        self.author = author
        self.width = width
        self.height = height
    }
    var toDict: [String:Any] {
        var dict: [String:Any] = [:]
        dict["description"] = description
        dict["author"] = author
        dict["width"] = width
        dict["height"] = height
        if let photoURL = self.photoURL {
            dict["photo"] = photoURL
        }
        return dict
    }
}

final class DataManager {
    //private constructor
    private init() {
        databaseRef = Database.database().reference()
    }
    //single instance
    static let shared = DataManager()
    var databaseRef: DatabaseReference!
    var userUID: String?
    
    func createPost (post:PostModel, image:UIImage, progress: @escaping (Double) -> (), callback: @escaping (Bool) -> () ) {
        guard let userID = userUID else {
            callback (false)
            return
        }
        //key for data
        let key = databaseRef.child("posts").childByAutoId().key
        let storageRef = Storage.storage().reference(forURL: "gs://individualstudymarkus.appspot.com/")
        //image path (location of pic)
        let photoPath = "posts/\(userID)/\(String(describing: key))/photo.jpg"
        let imageRef = storageRef.child(photoPath)
        //deals w metaData storage
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        metadata.customMetadata = ["userId": userID]
        //converts the image to JPEG format to save onto firebase
        let data = UIImageJPEGRepresentation(image, 0.9)
        //upload data and metadata
        let uploadTask = imageRef.putData(data!, metadata: metadata)
        uploadTask.observe(.progress) { snapshot in
            //upload reported progress
            let complete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            progress (complete)
        }
        uploadTask.observe(.success) { [unowned uploadTask, weak self]
            snapshot in
            //upload completed successfully
            uploadTask.removeAllObservers()
            post.photoURL = photoPath
            post.width = Int (image.size.width)
            post.height = Int (image.size.height)
            //save the post
            let postData = post.toDict
            let childUpdates = ["/posts/\(String(describing: key))": postData, "myposts/\(userID)/\(String(describing: key))/": postData]
            //create new records
            self?.databaseRef.updateChildValues(childUpdates)
            callback(true)
        }
        uploadTask.observe(.failure) { [unowned uploadTask] snapshot in
            uploadTask.removeAllObservers()
            callback(false)
            if let error = snapshot.error as NSError? {
                switch StorageErrorCode(rawValue: error.code)! {
                case .objectNotFound:
                    //file doesn't exist
                    print("Object not found")
                    break
                case .unauthorized:
                    print("user has no permissions")
                    break
                case .cancelled:
                    //user canceled the uploaded
                    print("upload was cancelled")
                    break
                case .unknown:
                    //unknown error occurred
                    break
                default:
                    // separate error occured
                    break
                }
            }
        }
    }
}
