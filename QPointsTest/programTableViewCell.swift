//
//  programTableViewCell.swift
//  QPointsTest
//
//  Created by Olaf Peters on 28.03.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class programTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProgramNameField: UILabel!
    @IBOutlet weak var ProgramPointsField: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
