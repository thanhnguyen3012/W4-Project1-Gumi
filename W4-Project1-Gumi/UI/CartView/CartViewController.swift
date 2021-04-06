//
//  CartViewController.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 05/04/2021.
//

import UIKit

protocol CartViewControllerDelegate {
    func cartViewController(_ cartViewController: CartViewController, updateFromCart: [Item])
}

class CartViewController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    
    var listOfItem = [Item]()
    var delegate: CartViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        title = "Cart"
        
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(CartTableViewCell.nib, forCellReuseIdentifier: CartTableViewCell.identifier)
    }
    
    func prepareData(listOfItem: [Item]) {
        self.listOfItem = listOfItem
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.cartViewController(self, updateFromCart: listOfItem)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.bindData(item: listOfItem[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension CartViewController: CartTableViewCellDelegate {
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, updateItem: Bool) {
        itemTableView.reloadData()
    }
    
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, showAlert: UIAlertController) {
        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.deleteFromCart(tag: cartTableViewCell.tag)}))
        self.present(showAlert, animated: true, completion: nil)
    }
    
    func deleteFromCart(tag: Int) {
        listOfItem.remove(at: tag)
        itemTableView.reloadData()
    }
}

