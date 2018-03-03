//
//  ShowFoodReviewViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

class ShowFoodReviewViewController: UIViewController {
    
    var foodReview: FoodReview?
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descText: UILabel!
    
//    @IBOutlet weak var titleText: UITextField!
//    @IBOutlet weak var photoImageView: UIImageView!
//    @IBOutlet weak var RatingControl: RatingControl!
//    @IBOutlet weak var descText: UITextField!
//    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let foodReview = foodReview {
            titleText.text = foodReview.title
            RatingControl.rating = foodReview.rating
            photoImageView.image = foodReview.photo
            descText.text = foodReview.desc
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let CommentController = segue.destination as? CommentViewController
        
        CommentController?.foodReview = foodReview
       
        
        
        
        
    }
    

}
