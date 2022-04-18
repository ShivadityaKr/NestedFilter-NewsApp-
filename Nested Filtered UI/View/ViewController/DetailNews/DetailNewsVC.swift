//
//  DetailNewsVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 17/04/22.
//

import UIKit
protocol DetailNewsView: UIViewController {
    var titleLabel: UILabel! {get}
    var descLabel: UILabel! {get}
    var imageView: UIImageView! {get}
    var newsData: Post? {get}
    var backButton: UIButton! {get}
}
class DetailNewsVC: UIViewController, DetailNewsView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView : UIView!
    var uiVc : DetailNewsUIVC!
    var newsData: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = scrollContentView.bounds.size
        uiVc.view = self
    }
    class func instantiate() -> DetailNewsVC {
        let vc = UIStoryboard.home.instanceOf(viewController: DetailNewsVC.self)!
        vc.uiVc = DetailNewsUIVC()
        return vc
    }
}
