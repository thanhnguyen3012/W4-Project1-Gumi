//
//  HomeViewController.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 05/04/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var totalItemInCartLabel: UILabel!
    
    var listOfItem : [Item] = [ Item(thumbnail: "🫐", name: "Blueberry", price: 87.0, backgroundColor: UIColor(red: 201/255, green: 229/255, blue: 255/255, alpha: 1)),
                                Item(thumbnail: "🍑", name: "Peach", price: 35.2, backgroundColor: UIColor(red: 1, green: 211/255, blue: 171/255, alpha: 1)),
                                Item(thumbnail: "🥑", name: "Avocado", price: 40.5, backgroundColor: UIColor(red: 228/255, green: 1, blue: 158/255, alpha: 1)),
                                Item(thumbnail: "🥔", name: "Potato", price: 8.3, backgroundColor: UIColor(red: 242/255, green: 232/255, blue: 203/255, alpha: 1)),
                                Item(thumbnail: "🥥", name: "Coconut", price: 21.3, backgroundColor: UIColor(red: 227/255, green: 204/255, blue: 186/255, alpha: 1)),
                                Item(thumbnail: "🥝", name: "Kiwi", price: 95.2, backgroundColor: UIColor(red: 228/255, green: 240/255, blue: 163/255, alpha: 1)),
                                Item(thumbnail: "🍌", name: "Banana", price: 34.0, backgroundColor: UIColor(red: 1, green: 240/255, blue: 176/255, alpha: 1)),
                                Item(thumbnail: "🍈", name: "Melon", price: 16.8, backgroundColor: UIColor(red: 222/255, green: 222/255, blue: 197/255, alpha: 1)),
                                Item(thumbnail: "🍐", name: "Pear", price: 57.3, backgroundColor: UIColor(red: 252/255, green: 1, blue: 217/255, alpha: 1))]
    var cartList = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(ItemCollectionViewCell.nib, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }

    @IBAction func cartButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CartView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.prepareData(listOfItem: cartList)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func reloadCartList() {
        cartList.removeAll()
        cartList.append(contentsOf: listOfItem.filter({ $0.amount > 0 }))
        totalItemInCartLabel.text = "\(cartList.count)"
    }
    
    func checkAmountInCart(item: Item) -> Int {
        for i in cartList {
            if ((i.name == item.name) && (i.thumbnail == item.thumbnail)) {
                return i.amount
            }
        }
        return 0
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        cell.bindData(item: listOfItem[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width - 45) / 2), height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
}

extension HomeViewController: itemCollectionViewCellDelegate {
    func itemCollectionViewCell(_ itemCollectionViewCell: ItemCollectionViewCell, updateItem: Bool) {
        reloadCartList()
        itemCollectionView.reloadData()
    }
}

extension HomeViewController: CartViewControllerDelegate {
    func cartViewController(_ cartViewController: CartViewController, updateFromCart: [Item]) {
        cartList = updateFromCart
        totalItemInCartLabel.text = "\(cartList.count)"
        
        for i in 0 ..< listOfItem.count {
            listOfItem[i].amount = checkAmountInCart(item: listOfItem[i])
        }
        itemCollectionView.reloadData()
    }
}
