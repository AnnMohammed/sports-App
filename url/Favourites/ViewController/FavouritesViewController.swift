//
//  FavouritesViewController.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    var offlineData: [OfflineStorage]?{
        didSet{
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()
            }
        }
    }
    
    let database = DatabaseHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        
        favouritesTableView.register(UINib(nibName: LeagueTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: LeagueTableViewCell.cellID)
        
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        
        favouritesTableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        offlineData = database.fetch(OfflineStorage.self)
        print(offlineData?.count)
        print(offlineData)
        
    }
    
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offlineData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favouritesTableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.cellID, for: indexPath) as? LeagueTableViewCell else { return UITableViewCell() }
        
        let item = offlineData?[indexPath.row]
        cell.tilteOfLeagueLabel.text = item?.strLeagueAlternate
        let imgURL = URL(string: item?.strBadge ?? "")
        cell.leagueImage.sd_setImage(with: imgURL, completed: nil)
        cell.subTitleOfLeagueLabel.text = item?.strLeague
        
        cell.TappedButton = {
            //https://www.youtube.com/watch?v=kQNdke9P-X0
            if let url = URL(string: item?.strYoutube ?? ""),
               UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:]) { (opened) in
                    if(opened) {
                        print("Youtube Opened")
                    }
                }
            } else {
                print("Can't Open URL on Simulator")
            }
        }
        
        return cell
    }
    
    // to make swipe action in cell to remove product with indexPath.row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            guard let item = self.offlineData?[indexPath.row] else { return }
            self.favouritesTableView.beginUpdates()
            self.database.delete(object: item)
            self.offlineData?.remove(at: indexPath.row)
            self.favouritesTableView.deleteRows(at: [indexPath], with: .automatic)
            self.favouritesTableView.endUpdates()
            completionHandler(true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = offlineData?[indexPath.row]
        print(item?.idLeague)
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        VC.move = 1
        VC.id = item?.idLeague
        VC.offline = item
        self.navigationController?.pushViewController(VC, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

