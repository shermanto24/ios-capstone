//
//  UploadPurchaseViewController.swift
//  daily_budget_tracker
//
//  Created by stef h on 4/23/23.
//

import UIKit
import PhotosUI
import ParseSwift

class PurchaseViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var uploadButton: UIBarButtonItem!
   
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    private var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPickedImageTapped(_ sender: UIBarButtonItem) {
        var config = PHPickerConfiguration()
        
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    @IBAction func onUploadTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        if var currentUser = User.current {

            // Update the `lastPostedDate` property on the user with the current date.
            currentUser.timePosted = Date()

            // Save updates to the user (async)
            currentUser.save { [weak self] result in
                switch result {
                case .success(let user):
                    print("✅ User Saved! \(user)")

                    // Switch to the main thread for any UI updates
                    DispatchQueue.main.async {
                        // Return to previous view controller
                        self?.navigationController?.popViewController(animated: true)
                    }

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        
        var purchase = Purchase()
        
        purchase.imageFile = imageFile
        purchase.caption = descriptionTextField.text
        purchase.title = titleTextField.text
        
        // needs error checking in the app to see if it's actually a double
        purchase.cost = Double(costTextField.text!)
        
        purchase.user = User.current
        purchase.createdAt = Date()
        
        // Save purchase (async)
        purchase.save { [weak self] result in
            
            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let purchase):
                    print("✅ Purchase Saved! \(purchase)")

                    // Return to previous view controller
                    self?.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
    }
    
    
    @IBAction func onTakePhotoTapped(_ sender: Any) {
        // TODO: Pt 2 - Present camera
        // Make sure the user's camera is available
        // NOTE: Camera only available on physical iOS device, not available on simulator.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌📷 Camera not available")
            return
        }

        // Instantiate the image picker
        let imagePicker = UIImagePickerController()

        // Shows the camera (vs the photo library)
        imagePicker.sourceType = .camera

        // Allows user to edit image within image picker flow (i.e. crop, etc.)
        // If you don't want to allow editing, you can leave out this line as the default value of `allowsEditing` is false
        imagePicker.allowsEditing = true

        // The image picker (camera in this case) will return captured photos via it's delegate method to it's assigned delegate.
        // Delegate assignee must conform and implement both `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`
        imagePicker.delegate = self

        // Present the image picker (camera)
        present(imagePicker, animated: true)

    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
    
    extension PurchaseViewController: PHPickerViewControllerDelegate {
        
        // PHPickerViewController required delegate method.
        // Returns PHPicker result containing picked image data.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // Dismiss the picker
            picker.dismiss(animated: true)
            
            // Make sure we have a non-nil item provider
            guard let provider = results.first?.itemProvider,
                  // Make sure the provider can load a UIImage
                  provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            // Load a UIImage from the provider
            provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                
                // Make sure we can cast the returned object to a UIImage
                guard let image = object as? UIImage else {
                    self?.showAlert()
                    return
                }
                
                // Check for and handle any errors
                if let error = error {
                    self?.showAlert(description: error.localizedDescription)
                    return
                } else {
                    
                    // UI updates (like setting image on image view) should be done on main thread
                    DispatchQueue.main.async {
                        
                        // Set image on preview image view
                        self?.previewImageView.image = image
                        
                        // Set image to use when saving purchase
                        self?.pickedImage = image
                    }
                }
            }
        }
    }



