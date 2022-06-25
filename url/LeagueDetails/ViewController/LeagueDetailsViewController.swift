//
//  LeagueDetailsViewController.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var move: Int?
    
    var leagueData: Myleagues?
    var offline: OfflineStorage?
    
    var offlineData: [OfflineStorage]?
    
    var eventsData = [EventsData]()
    var teamsData = [TeamsData]()
    
    var id: String?
    
    let database = DatabaseHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        title = "League Details"
        
        navigationController?.navigationBar.tintColor = .systemRed
        if move == 1 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favorite"), style: .plain, target: self, action: #selector(addTapped))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favourite (1)"), style: .plain, target: self, action: #selector(addTapped))
        }
         //favourite (1) //favorite
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        detailsTableView.separatorStyle = .none
        
        detailsTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamsTableViewCell")
        detailsTableView.register(UINib(nibName: "SectionHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderTableViewCell")
        detailsTableView.register(UINib(nibName: "UpCommingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpCommingTableViewCell")
        detailsTableView.register(UINib(nibName: "CircleTeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "CircleTeamsTableViewCell")
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        getData()
        getTeamsData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        offlineData = database.fetch(OfflineStorage.self)
        print(offlineData?.count)
        print(offlineData)
        
    }
    
    @objc func addTapped() {
        print("tapped button !!")
        
        if move == 1 {
            
            // remove from favourites
            print("remove from favourites and nothing is happen here because i won't handle it yet !!")
            
        }else {
            
            guard let data = Myleagues.database.add(OfflineStorage.self) else { return }
            
            data.idLeague = leagueData?.idLeague ?? ""
            data.strLeague = leagueData?.strLeague ?? ""
            data.strLeagueAlternate = leagueData?.strLeagueAlternate ?? ""
            data.strYoutube = leagueData?.strYoutube ?? ""
            data.strBadge = leagueData?.strBadge ?? ""
            
            Myleagues.database.save()
            
            navigationItem.rightBarButtonItem?.image = UIImage(named: "favorite")
            
        }
        
    }
    
    private func getTeamsData() {
        
        let url = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"
        
        guard let endPoint = URL(string: url) else { return }
        
        
        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
                    if let error = error {
                        
                        print(error)
                        
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        
                        print("invalid url")
                        
                        return
                    }
                    
                    guard let data = data else{
                        
                        print("invalid data")
                        
                        return
                    }
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let item = try decoder.decode(TeamsModel.self, from: data)
                        print(item)
                        
                        self.teamsData = item.teams ?? []
                        print("teams Data model : \(self.teamsData)")
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else  { return }
                            self.detailsTableView.reloadData()
                        }
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
                task.resume()
        
    }
    
    private func getData() {
        
        let url = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(id ?? "")"
        
        guard let endPoint = URL(string: url) else { return }
        
        
        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
                    if let error = error {
                        
                        print(error)
                        
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        
                        print("invalid url")
                        
                        return
                    }
                    
                    guard let data = data else{
                        
                        print("invalid data")
                        
                        return
                    }
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let events = try decoder.decode(EventsModel.self, from: data)
                        print(events)
                        
                        self.eventsData = events.events ?? []
                        print("league Data model : \(self.eventsData)")
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else  { return }
                            self.detailsTableView.reloadData()
                        }
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
                task.resume()
        
    }
    
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 1
        }else if section == 3 {
            return 1
        }else if section == 4 {
            return 1
        }else {
            return eventsData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SectionHeaderTableViewCell", for: indexPath) as? SectionHeaderTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.link
            cell.sectionHeaderLabel.text = "Teams"
            return cell
            
        }else if indexPath.section == 1 {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "CircleTeamsTableViewCell", for: indexPath) as? CircleTeamsTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.magenta
            
            cell.teamsData = teamsData
            cell.circleImageCollectionView.reloadData()
            
            cell.DidSelect = { [weak self] teamsDataItems in
                
                guard let self = self else { return }
                
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamsDetailsViewController") as! TeamsDetailsViewController
                
                VC.teamsData = teamsDataItems
                
                self.navigationController?.pushViewController(VC, animated: false)
                
            }
            
            return cell
            
        }else if indexPath.section == 2 {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SectionHeaderTableViewCell", for: indexPath) as? SectionHeaderTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.link
            cell.sectionHeaderLabel.text = "UpComming Events"
            return cell
            
        }else if indexPath.section == 3 {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "TeamsTableViewCell", for: indexPath) as? TeamsTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.green
            cell.eventsData = eventsData
            cell.teamsCollectionView.reloadData()
            return cell
            
        }else if indexPath.section == 4 {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SectionHeaderTableViewCell", for: indexPath) as? SectionHeaderTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.link
            cell.sectionHeaderLabel.text = "Latest Results"
            return cell
            
        }else {
            
            guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "UpCommingTableViewCell", for: indexPath) as? UpCommingTableViewCell else { return UITableViewCell() }
            //cell.contentView.backgroundColor = UIColor.gray
            
            let item = eventsData[indexPath.row]
            
            let imgURL = URL(string: item.strThumb ?? "")
            cell.backgroundImageOutlet.sd_setImage(with: imgURL, completed: nil)
            
            cell.homeTeamLabel.text = item.strHomeTeam ?? "No name!"
            cell.homeTeamIntLabel.text = "score: \(item.intHomeScore ?? "0")"
            
            cell.awayTeamLabel.text = item.strAwayTeam ?? "No name!"
            cell.awayTeamIntLabel.text = "score: \(item.intAwayScore ?? "0")"
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 50
        }else if indexPath.section == 1 {
            return 100
        }else if indexPath.section == 2 {
            return 50
        }else if indexPath.section == 3 {
            return 120
        }else if indexPath.section == 4 {
            return 50
        }else {
            return 120
        }
        
    }
    
}
