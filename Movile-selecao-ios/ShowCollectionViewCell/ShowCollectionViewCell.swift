//
//  ShowCollectionViewCell.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 2/26/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import AsyncImageView
import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var showImage: AsyncImageView!
    @IBOutlet weak var showTitle: UILabel!
    
    // MARK: Inits
    override func awakeFromNib() {
        configureImageCrossfade()
    }
    
    // MARK: Private helpers
    private func configureImageCrossfade() {
        showImage.crossfadeDuration = 0.3
    }
    
    // MARK: Public methods
    func configureCellWithShow(show: ShowDisplayObject){
        showImage.imageURL = show.imageURL
        showTitle.text = show.title
        configureImageCrossfade()
    }
    
}