//
//  ViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/13.
//

import UIKit

import SnapKit
import Then
import RxSwift

class MainViewController: UIViewController {
    
    private var tableViewController: MainTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainViewModel = MainViewModel()
        self.tableViewController = MainTableViewController(with: mainViewModel)
        initViewController()
        setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSearchController()
    }
  
    private func initViewController() {
        title = "연락처"
        view.backgroundColor = .white
    }
    
    private func setSearchController() {
        navigationItem.searchController = tableViewController.searchController
        navigationItem.title = "연락처"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTapped))
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        embed(tableViewController)
        view.addSubview(tableViewController.view)
    }

    private func setConstraints() {
        tableViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension MainViewController {
    @objc
    private func addButtonDidTapped() {
        let createViewController = CreateViewController()
        let navCreateViewController: UINavigationController = UINavigationController(rootViewController: createViewController)
        present(navCreateViewController, animated: true, completion: nil)
    }
}

