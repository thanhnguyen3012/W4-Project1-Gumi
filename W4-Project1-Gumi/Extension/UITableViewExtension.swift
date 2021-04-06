//
//  UITableViewExtension.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 06/04/2021.
//

import UIKit

extension UITableView {
    func indexPathForView(view: UIView) -> IndexPath? {
        let originInTableView = self.convert(CGPoint.zero, from: (view))
        return self.indexPathForRow(at: originInTableView)
    }
}
