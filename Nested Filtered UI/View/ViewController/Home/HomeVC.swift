//
//  HomeVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 16/04/22.
//

import UIKit
protocol HomeView: UIViewController {
    var filterButton: UIButton! {get}
    var filterTableView: UITableView! {get}
    var tableView: UITableView! {get}
    var filterTableHeight: NSLayoutConstraint! {get set}
}
protocol HomeViewModel {
    var uiVc : HomeUIVC! {get set}
}
class HomeVC: UIViewController, HomeView,HomeViewModel {
    @IBOutlet weak var filterTableHeight: NSLayoutConstraint!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var uiVc : HomeUIVC!
    var viewModel : HomeVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiVc.view = self
        viewModel.viewModel = self
        
    }
    class func instantiate() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        vc.uiVc = HomeUIVC()
        vc.viewModel = HomeVM()
        return vc
    }
}
