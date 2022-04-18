//
//  NewsListTVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 16/04/22.
//

import UIKit

class NewsListTVC: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(data: Post) {
        titleLabel.text = data.title
        descLabel.text = data.description
        DispatchQueue.global().async {
            self.cellImageView.loadImageCacheWithUrlString(urlString: data.urlToImage)
        }
    }
    
}
