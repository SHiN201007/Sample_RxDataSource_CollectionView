//
//  FootCollectionViewCell.swift
//  SampleCollection
//
//  Created by 松丸真 on 2022/02/17.
//

import UIKit
import Reusable

class FootCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }
    
    private func configView() {
        backView.layer.cornerRadius = 10.0
    }

}
