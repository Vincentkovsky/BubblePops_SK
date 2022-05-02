//
//  MyTableViewCell.swift
//  BubblePops_SK
//
//  Created by Vincent Jin on 2022/4/30.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, with name: String){
        myLabel.text = title
        nameLabel.text = name
        myLabel.textAlignment = .center
        nameLabel.textAlignment = .center
    }
    
    @IBOutlet var myLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
