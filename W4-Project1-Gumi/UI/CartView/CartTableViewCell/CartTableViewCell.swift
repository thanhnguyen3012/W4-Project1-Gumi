//
//  CartTableViewCell.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 05/04/2021.
//

import UIKit

protocol CartTableViewCellDelegate {
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, updateItem: Bool)
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, showAlert: UIAlertController)
}

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailBackground: UIView!
    @IBOutlet weak var thumbnailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var item = Item(thumbnail: "", name: "", price: 0.0)
    var delegate: CartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        addButton.layer.cornerRadius = 8
        addButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.1
        
        
        removeButton.layer.cornerRadius = 8
        removeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        removeButton.layer.shadowColor = UIColor.black.cgColor
        removeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        removeButton.layer.shadowRadius = 5
        removeButton.layer.shadowOpacity = 0.1
        
    }
    
    func bindData(item: Item) {
        self.item = item
        
        thumbnailBackground.backgroundColor = item.backgroundColor
        thumbnailLabel.text = item.thumbnail
        nameLabel.text = item.name
        priceLabel.text = "$\(item.price * Double(item.amount))"
        amountLabel.text = "\(item.amount)"
        nameLabel.textColor = item.backgroundColor
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        if item.reduce() {
            delegate?.cartTableViewCell(self, updateItem: true)
            if item.amount == 0 {
                let alert = UIAlertController(title: "Do you want to remove this item from the cart?", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in self.cancelDeleteItem()}))
                delegate?.cartTableViewCell(self, showAlert: alert)
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        item.increase()
        delegate?.cartTableViewCell(self, updateItem: true)
    }
    
    func cancelDeleteItem() {
        item.amount = 1
        amountLabel.text = "\(item.amount)"
        priceLabel.text = "$\(item.price)"
    }
}
