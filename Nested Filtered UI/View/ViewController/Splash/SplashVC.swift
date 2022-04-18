//
//  SplashVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 16/04/22.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadscreen()
    }
    private func loadscreen(){
        let vc = HomeVC.instantiate()
        UIStoryboard.makeNavigationControllerAsRootVC(vc)
    }

}
