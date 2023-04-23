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
    
    private var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onPickedImageTapped(_ sender: UIBarButtonItem) {
        // TODO: Pt 1 - Present Image picker
        // Create and configure PHPickerViewController

        // Create a configuration object
        var config = PHPickerConfiguration()

        // Set the filter to only show images as options (i.e. no videos, etc.).
        config.filter = .images

        // Request the original file format. Fastest method as it avoids transcoding.
        config.preferredAssetRepresentationMode = .current

        // Only allow 1 image to be selected at a time.
        config.selectionLimit = 1

        // Instantiate a picker, passing in the configuration.
        let picker = PHPickerViewController(configuration: config)

        // Set the picker delegate so we can receive whatever image the user picks.
        picker.delegate = self

        // Present the picker
        present(picker, animated: true)
    }
    
    
    @IBAction func onTakePhotoTapped(_ sender: Any) {
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
                //self?.showAlert()
                return
            }
            
            // Check for and handle any errors
            if let error = error {
                //self?.showAlert(description: error.localizedDescription)
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
