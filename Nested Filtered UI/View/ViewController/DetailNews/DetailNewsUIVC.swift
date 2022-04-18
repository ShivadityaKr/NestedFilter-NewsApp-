//
//  DetailNewsUIVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 17/04/22.
//

import UIKit

class DetailNewsUIVC : NSObject {
    var view: DetailNewsView? {
        didSet {
            setupData()
        }
    }
    private func setupData() {
        DispatchQueue.global().async {
            self.view?.imageView.loadImageCacheWithUrlString(urlString: self.view?.newsData?.urlToImage ?? "")
        }
        self.view?.titleLabel.text = self.view?.newsData?.title
        self.view?.descLabel.text = self.view?.newsData?.description
        self.view?.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    @objc func didTapBackButton() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
