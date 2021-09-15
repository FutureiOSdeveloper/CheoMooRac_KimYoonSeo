//
//  UIStackView+addArrangedSubviews.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}
