//
//  FilterTVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 16/04/22.
//

import UIKit

class FilterTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        checked = false
    }
    func setTitle(text: String) {
        titleLabel.text = text
    }
    func setData(source: FilterData.Source) {
        titleLabel.text = source.source
    }
    func setData(desc: FilterData.Description) {
        titleLabel.text = desc.description
    }
    var checked: Bool! {
        didSet {
            if (self.checked == true) {
                if #available(iOS 13.0, *) {
                    checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                } else {
                    checkButton.backgroundColor = .gray
                }
            } else{
                checkButton.backgroundColor = .clear
                checkButton.setImage(nil, for: .normal)
            }
        }
    }
}
