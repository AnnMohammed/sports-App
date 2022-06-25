//
//  ViewController.swift
//  url
//
//  Created by Ann mohammed on 21/06/2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var dataModel = [Sports]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sports"
        
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self

        getData()
        
    }
    private func getData(){
        
        let url = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        
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
                        let sports = try decoder.decode(Response.self, from: data)
                        print(sports)
                        
                        self.dataModel = sports.sports ?? []
                        print("my data model : \(self.dataModel)")
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else  { return }
                            self.homeCollectionView.reloadData()
                        }
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
                task.resume()
        
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SportIDCell else { return UICollectionViewCell() }
        
        let item = dataModel[indexPath.row]
        
        DispatchQueue.main.async {
            cell.containerView.layer.cornerRadius = 10
            cell.sportsImageOutlet.layer.cornerRadius = 10
            cell.shadowViewOutlet.layer.cornerRadius = 10
            
            cell.idLabelOutlet.text = item.strSport ?? ""
            let imgURL = URL(string: item.strSportThumb ?? "")
            cell.sportsImageOutlet.sd_setImage(with: imgURL, completed: nil)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = dataModel[indexPath.row]
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
        VC.leagueName = item.strSport
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (homeCollectionView.frame.size.width - 10) / 2, height: 120)
    }
    
}




