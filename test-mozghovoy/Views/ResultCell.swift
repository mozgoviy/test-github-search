//
//  ResultCell.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countStarsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillDataWithModel(model: Repository) {
        nameLabel.text = model.descriptionRepo
        nameLabel.setLimit()
        countStarsLabel.text = "\(model.stars)"
    }

}
