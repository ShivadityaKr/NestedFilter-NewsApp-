//
//  HomeVM.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 17/04/22.
//

import UIKit
protocol HomeDataSource {
    var dataSource: [Post]! {get}
}
class HomeVM : NSObject, HomeDataSource {
    var dataSource: [Post]!
    
    var viewModel: HomeViewModel? {
        didSet {
            fetchData()
        }
    }
    let fetchAPI = RestManager()
    func fetchData() {
        fetchAPI.fetchData { post in
            self.dataSource = post
            self.viewModel?.uiVc.viewModel = self
        }
    }
}
