//
//  LeagueViewController.swift
//  url
//
//  Created by Ann mohammed on 23/06/2022.
//

import UIKit

class LeagueViewController: UIViewController {
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var leagueName: String?
    var leagueData = [Myleagues]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Leagues"
        
        navigationController?.navigationBar.tintColor = .systemRed
        
        leaguesTableView.register(UINib(nibName: LeagueTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: LeagueTableViewCell.cellID)
        
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.separatorStyle = .none
        
        getData()
        
    }
    
    private func getData() {
        
        let url = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=\(leagueName ?? "")"
        
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
                        let sports = try decoder.decode(LeaguesModel.self, from: data)
                        print(sports)
                        
                        self.leagueData = sports.countries ?? []
                        print("league Data model : \(self.leagueData)")
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else  { return }
                            self.leaguesTableView.reloadData()
                        }
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
                task.resume()
        
    }
    
}

extension LeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagueData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = leaguesTableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.cellID, for: indexPath) as? LeagueTableViewCell else { return UITableViewCell() }
        
        let item = leagueData[indexPath.row]
        cell.configure(model: item)
        cell.TappedButton = {
            //https://www.youtube.com/watch?v=kQNdke9P-X0
            if let url = URL(string: item.strYoutube ?? ""),
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = leagueData[indexPath.row]
        print(item.idLeague)
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        VC.id = item.idLeague
        VC.leagueData = item
        self.navigationController?.pushViewController(VC, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
