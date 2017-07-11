//
//  ViewController.swift
//  FoodTracker
//
//  Created by byung-soo kwon on 2017. 6. 30..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Handle text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{

        //hide the keyboard
        textField.resignFirstResponder()
        return true
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
    
        mealNameLabel.text = textField.text
        
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
    
        // Dismiss the Picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Do something with selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //The info dictionary may contain multiple representations of the image. You want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provied followe \(info)")
        }
        
        // Set PhotoImageView to display selected image
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from therir photolibrary
        let imagePickController = UIImagePickerController()
        
        // Only allows photos to be picked, not taken
        imagePickController.sourceType = .photoLibrary
        
        // Make Sure ViewController is notified when the user picks an image.
        imagePickController.delegate = self
        present(imagePickController, animated: true, completion: nil)
        
    }
 
    
    
}

