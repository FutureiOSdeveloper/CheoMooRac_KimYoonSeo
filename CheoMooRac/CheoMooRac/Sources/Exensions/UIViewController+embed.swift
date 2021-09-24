//
//  UIViewController+embed.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import UIKit

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
