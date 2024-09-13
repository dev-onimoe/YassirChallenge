//
//  CharacterTableViewCell.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 10/09/2024.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Charimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
