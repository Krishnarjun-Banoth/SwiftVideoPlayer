//
//  HomeViewController.swift
//  KrishnaVideoPlayer
//
//  Created by Krishnarjun Banoth on 02/02/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    fileprivate var viewModel: HomeViewModel!
    
    @IBOutlet weak var homeTableView: HomeTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(self)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        _ = viewModel.loadJson(filename: "assignment")
    }
}



extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let data = viewModel.homeData {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else { return }
        
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerValue = ""
        let sectionHeader = UIView(frame: CGRect(x: 0,y: 0,width: tableView.frame.width,height: 50))
        if let data = viewModel.homeData {
            headerValue = data[section].title
            sectionHeader.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            let titleLabel = UILabel(frame: CGRect(x: 15,y: 40,width: sectionHeader.frame.width,height: sectionHeader.frame.height-20))
            
            titleLabel.attributedText = SFUIAttributedText.boldAttributedTextForString(headerValue , size: 20, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            sectionHeader.addSubview(titleLabel)
        }
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = viewModel.homeData {
            return data[collectionView.tag].nodes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        if let data = viewModel.homeData {
            cell.videoThumbnailImage.image = #imageLiteral(resourceName: "no-image")
            cell.layer.cornerRadius = 10
            cell.videoThumbnailImage.createThumbnailOfVideoFromRemoteUrl(url: data[indexPath.section].nodes[indexPath.row].video.encodeURL)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = viewModel.homeData {
            let urlString = data[collectionView.tag].nodes[indexPath.row].video.encodeURL
            let videoURL = URL(string: urlString)!
            let player = AVPlayer(url: videoURL)
            let vc = AVPlayerViewController()
            vc.player = player
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 120, height: 190)
    }
}



extension HomeViewController: HomeViewModelDelegate {
    func reload() {

    }
}
