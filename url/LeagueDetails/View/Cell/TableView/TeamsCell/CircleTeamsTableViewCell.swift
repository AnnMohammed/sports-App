//
//  CircleTeamsTableViewCell.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class CircleTeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var circleImageCollectionView: UICollectionView!
    
    var teamsData = [TeamsData]()
    
    var DidSelect: ((_ model: TeamsData?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        circleImageCollectionView.register(UINib(nibName: "CircleTeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircleTeamsCollectionViewCell")
        
        circleImageCollectionView.dataSource = self
        circleImageCollectionView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CircleTeamsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = circleImageCollectionView.dequeueReusableCell(withReuseIdentifier: "CircleTeamsCollectionViewCell", for: indexPath) as? CircleTeamsCollectionViewCell else { return UICollectionViewCell() }
        
        let item = teamsData[indexPath.row]
        let imgURL = URL(string: item.strTeamBanner ?? "")
        cell.teamImage.sd_setImage(with: imgURL, completed: nil)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = teamsData[indexPath.item]
        DidSelect?(item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (circleImageCollectionView.frame.size.width - 10) / 4, height: 100)
        
    }
    
}
