//
//  CreatFoodReviewViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//


import UIKit
import os.log
import Alamofire
import SwiftyJSON

class CreatFoodReviewViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var foodReview: FoodReview?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = titleText.text ?? ""
        let photo = photoImageView.image
        let rating = RatingControl.rating
        let desc = descText.text ?? ""
        let userName = "haung"
        let userID = "1"
        
        //上传
        let imageData = UIImagePNGRepresentation(photo!)
        
        let httpHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "multipart/form-data"
        ]
//        let httpHeaders:HTTPHeaders = ["Content-Type": "multipart/form-data"]
//        Alamofire.HTTPHeaders.merging(["Content-Type": "multipart/form-data",
//                                       "boundary":"----WebKitFormBoundary7MA4YWxkTrZu0gW"])
//        var headparams:NSMutableDictionary = NSMutableDictionary()
//        headparams["Content-Type"]="multipart/form-data"
//        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        defaultHeaders["DNT"] = "1 (Do Not Track Enabled)"
//
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = defaultHeaders
//
//        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "foodPictureEntry")
                multipartFormData.append(title.data(using: String.Encoding.utf8)!, withName: "foodName",fileName:"x.png",mimeType:"image/png")
                multipartFormData.append(String(rating).data(using: String.Encoding.utf8)!, withName: "level")
                multipartFormData.append(desc.data(using: String.Encoding.utf8)!, withName: "foodIntro")
                multipartFormData.append(userID.data(using: String.Encoding.utf8)!, withName: "id")
        },
            to: "http://119.29.189.146:8080/foodTracker/foodRecord/newFoodRecord",
            headers:httpHeaders,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print()
                    print(encodingError)
                }
        }
        )
        
        foodReview = FoodReview(id: "-1",title: title, photo: photo, rating: rating, desc:desc,userName: userName )
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        //        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
}

