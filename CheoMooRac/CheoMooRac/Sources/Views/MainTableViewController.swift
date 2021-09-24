//
//  MainTableViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    private var viewModel: MainViewModelProtocol
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
