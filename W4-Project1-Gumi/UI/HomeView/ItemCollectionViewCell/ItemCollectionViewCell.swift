//
//  ItemCollectionViewCell.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 05/04/2021.
//

import UIKit

protocol itemCollectionViewCellDelegate {
    func itemCollectionViewCell(_ itemCollectionViewCell: ItemCollectionViewCell, updateItem: Bool)
}

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var thumbnailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var item = Item(thumbnail: "", name: "", price: 0.0)
    var delegate: itemCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        addButton.layer.cornerRadius = 16
        addButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        addButton.alpha = 0.5
        
        removeButton.clipsToBounds = true
        removeButton.layer.cornerRadius = 16
        removeButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        removeButton.alpha = 0.5
        
        amountLabel.clipsToBounds = true
        amountLabel.layer.cornerRadius = 16
        amountLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        amountLabel.alpha = 0.5
        
        layer.cornerRadius = 16
        backgroundColor = item.backgroundColor
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 3, height: 5)
        layer.shadowOpacity = 0.1
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        if item.reduce() {
            print("^^^^^^^^^^^^^^^^^^^ Remove button")
            delegate?.itemCollectionViewCell(self, updateItem: true)
        } else {
            removeButton.isHidden = true
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        print("^^^^^^^^^^^^^^^^^^^ Add button")
        item.increase()
        delegate?.itemCollectionViewCell(self, updateItem: true)
    }
    
    func bindData(item: Item) {
        self.item = item
        amountLabel.text = "\(item.amount)"
        thumbnailLabel.text = item.thumbnail
        nameLabel.text = item.name
        priceLabel.text = "$\(item.price)"
        backgroundColor = item.backgroundColor
        removeButton.isHidden = item.amount > 0 ? false : true
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
