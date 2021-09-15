//
//  UITableView+Generic.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
  static var nib: UINib? { get }
}

extension Reusable {
  static var reuseIdentifier: String { return String(describing: self) }
  static var nib: UINib? { return nil }
}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
    if let nib = T.nib {
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    } else {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
  }

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
  }

    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
    if let nib = T.nib {
        self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    } else {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
  }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
  }
}
