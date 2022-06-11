//
//  TripCollectionViewCell.swift
//  Carousel Loke UI App
//
//  Created by Kukina Anastasia on 18.01.2021.
//

import UIKit

protocol TripCollectionCellDelegate {
    func didLikeButtonPressed(cell: TripCollectionViewCell)
}

class TripCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var delegate: TripCollectionCellDelegate?
    
    var isLiked: Bool = false {
        
        didSet {
            if isLiked {
                likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        delegate?.didLikeButtonPressed(cell: self)
    }
    
}
