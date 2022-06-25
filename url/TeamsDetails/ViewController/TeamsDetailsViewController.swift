//
//  TeamsDetailsViewController.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class TeamsDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamnameLabel: UILabel!
    @IBOutlet weak var teamShortLabel: UILabel!
    @IBOutlet weak var alternateLabel: UILabel!
    @IBOutlet weak var leaguelabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var teamBanner: UIImageView!
    
    var teamsData: TeamsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataInUI()
        
    }
    
    func setDataInUI() {
        
        teamnameLabel.text = teamsData?.strTeam ?? ""
        teamShortLabel.text = teamsData?.strTeamShort ?? ""
        alternateLabel.text = teamsData?.strAlternate ?? ""
        leaguelabel.text = teamsData?.strLeague ?? ""
        stadiumLabel.text = teamsData?.strStadium ?? ""
        let imgURL = URL(string: teamsData?.strTeamBanner ?? "")
        teamBanner.sd_setImage(with: imgURL, completed: nil)
        
    }
    
}
