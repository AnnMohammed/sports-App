//
//  TeamsTableViewCell.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var eventsData = [EventsData]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        teamsCollectionView.register(UINib(nibName: "LatestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestCollectionViewCell")
        
        teamsCollectionView.dataSource = self
        teamsCollectionView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TeamsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "LatestCollectionViewCell", for: indexPath) as? LatestCollectionViewCell else { return UICollectionViewCell() }
        
        let item = eventsData[indexPath.row]
        
        let imgURL = URL(string: item.strThumb ?? "")
        cell.backgroundImageOutlet.sd_setImage(with: imgURL, completed: nil)
        
        cell.eventNameLabel.text = item.strEvent ?? ""
        
        cell.eventDateLabel.text = "Event Date :"
        cell.eventDateValueLabel.text = item.dateEvent ?? ""
        
        cell.eventTimeLabel.text = "Event Time :"
        cell.eventTimeValueLabel.text = item.strTime ?? ""
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: teamsCollectionView.frame.size.width - 10, height: 100)
        
    }
    
}
