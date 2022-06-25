//
//  UpCommingTableViewCell.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class UpCommingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageOutlet: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var homeTeamIntLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var awayTeamIntLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
