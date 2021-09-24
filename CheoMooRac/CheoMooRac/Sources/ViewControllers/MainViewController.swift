//
//  ViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/13.
//

import UIKit


import SnapKit
import Then

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}


class MainViewController: UIViewController {
    
    var tableViewController: MainTableViewController!
    
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
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.title = "연락처"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTapped))
        
        searchController.searchResultsUpdater = self
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

extension MainViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

    }
}
