//
//  PurchaseCell.swift
//  daily_budget_tracker
//
//  Created by Minseo Cho on 4/23/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PurchaseCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var purchaseImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    private var imageDataRequest: DataRequest?

    func configure(with purchase: Purchase) {
        // title
        if purchase.title != nil {
            titleLabel.text = purchase.title
        }
        else {
            titleLabel.text = ""
        }

        // Image
        if let imageFile = purchase.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.purchaseImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        if purchase.caption != nil {
            descriptionLabel.text = purchase.caption
        }
        else {
            descriptionLabel.text = ""
        }
        
        // Cost
        if purchase.cost != nil {
            costLabel.text = "$" + String(format: "%.2f", purchase.cost!)
        }
        else {
            costLabel.text = ""
        }

        // Date
        /*
        if let date = purchase.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
         */
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        purchaseImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
}
