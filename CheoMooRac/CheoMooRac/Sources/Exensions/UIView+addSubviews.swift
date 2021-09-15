//
//  UIView+addSubviews.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
