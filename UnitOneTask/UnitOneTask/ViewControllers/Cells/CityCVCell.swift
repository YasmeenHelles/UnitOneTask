//
//  CityCVCell.swift
//  UnitOneTask
//
//  Created by Helles, Yasmeen on 24/03/2022.
//

import UIKit

class CityCVCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCity: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCity.setRounded(radius: 10)
    }

}
