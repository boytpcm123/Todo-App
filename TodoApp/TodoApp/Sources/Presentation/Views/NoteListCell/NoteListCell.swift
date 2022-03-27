//
//  CallListCell.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit

class NoteListCell: UITableViewCell {
    
    // MARK: - OUTLET
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    
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
        priceLabel.text = ""
        quantityLabel.text = ""
    }
    
    func bindData(_ itemNoted: ItemNotedViewModel) {
        nameLabel.text = itemNoted.getName()
        priceLabel.text = "\(itemNoted.getPrice())"
        quantityLabel.text = "\(itemNoted.getQuantity())"
    }
    
}
