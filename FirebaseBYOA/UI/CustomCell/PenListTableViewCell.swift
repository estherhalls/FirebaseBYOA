//
//  PenListTableViewCell.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import UIKit

class PenListTableViewCell: UITableViewCell {
    
// MARK: - Outlets
    @IBOutlet weak var penBrandModelNamesLabel: UILabel!
    @IBOutlet weak var nibSizeMaterialLabel: UILabel!
    
    // MARK: - Methods
    func configureCell(with pen: FountainPen) {
        penBrandModelNamesLabel.text = "\(pen.brandName) \(pen.penName)"
        nibSizeMaterialLabel.text = "\(pen.nibSize), \(pen.nibMaterial)"
    }
    
} // End of Class
