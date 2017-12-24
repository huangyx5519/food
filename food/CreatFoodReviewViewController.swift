//
//  CreatFoodReviewViewController.swift
//  food
//
//  Created by hyx on 2017/12/20.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import os.log

class CreatFoodReviewViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARK: Properties

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
//    @IBOutlet weak var titleText: UITextField!
//    @IBOutlet weak var titleText: UITextField!
//
//    @IBOutlet weak var descText: UITextField!
//
//    @IBOutlet weak var RatingControl: RatingControl!
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
//        meal = Meal(name: name, photo: photo, rating: rating)
        
        foodReview = FoodReview(title: title, photo: photo, rating: rating, desc:desc,userName: userName )
        
//        guard let food1 = FoodReview(title: title, photo: photo, rating: rating, desc:desc,userName: userName ) else {
//            fatalError("Unable to instantiate meal1")
//        }
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
