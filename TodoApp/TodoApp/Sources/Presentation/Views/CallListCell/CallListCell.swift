//
//  CallListCell.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit

class CallListCell: UITableViewCell {
    
    // MARK: - OUTLET
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        phoneLabel.text = ""
    }
    
    func bindData(_ userCall: UserCall) {
        nameLabel.text = userCall.name
        phoneLabel.text = userCall.number
    }
    
}
