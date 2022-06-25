//
//  LeagueTableViewCell.swift
//  url
//
//  Created by Ann mohammed on 23/06/2022.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    static let cellID = "LeagueTableViewCell"
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var tilteOfLeagueLabel: UILabel!
    @IBOutlet weak var subTitleOfLeagueLabel: UILabel!
    @IBOutlet weak var youtubeImage: UIImageView!
    @IBOutlet weak var youtubeButtonOutlet: UIButton!
    
    var TappedButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Myleagues) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tilteOfLeagueLabel.text = model.strLeagueAlternate
            let imgURL = URL(string: model.strBadge ?? "")
            self.leagueImage.sd_setImage(with: imgURL, completed: nil)
            self.subTitleOfLeagueLabel.text = model.strLeague
        }
        
    }
    
    @IBAction func youtubeButtonAction(_ sender: Any) {
        TappedButton?()
    }
    
}
