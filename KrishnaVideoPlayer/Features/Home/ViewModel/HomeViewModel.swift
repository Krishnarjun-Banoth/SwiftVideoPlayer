//
//  HomeViewModel.swift
//  KrishnaVideoPlayer
//
//  Created by Krishnarjun Banoth on 02/02/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func reload()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var homeData : HomeDetails?
    init(_ delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadJson(filename fileName: String) -> HomeDetails? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HomeDetails.self, from: data)
                homeData = jsonData
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

}
