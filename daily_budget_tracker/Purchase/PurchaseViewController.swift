//
//  UploadPurchaseViewController.swift
//  daily_budget_tracker
//
//  Created by stef h on 4/23/23.
//

import UIKit
import PhotosUI
import ParseSwift

class PurchaseViewController: UIViewController {
    
    //@IBOutlet weak var previewImageView: UIImageView!
    //@IBOutlet weak var uploadButton: UIBarButtonItem!
    //@IBOutlet weak var previewImageView: UIImageView!
    //@IBOutlet weak var titleTextField: UITextField!
    //@IBOutlet weak var costTextField: UITextField!
    //@IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    private var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPickedImageTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    @IBAction func onUploadTapped(_ sender: Any) {
        view.endEditing(true)
        
        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        
        var post = Post()
        
        post.imageFile = imageFile
        post.caption = descriptionTextField.text
        post.title = titleTextField.text
        post.cost = costTextField.text
        
        //post.user = User.current
        
        // Save post (async)
        post.save { [weak self] result in
            
            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")

                    // Return to previous view controller
                    self?.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
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
                        // UNCOMMENT WHEN IT WORKS
                        //self?.previewImageView.image = image
                        
                        // Set image to use when saving post
                        self?.pickedImage = image
                    }
                }
            }
        }
    }
