//
//  ViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/13.
//

import UIKit


import SnapKit
import Then

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var filteredList: [String] = []
    private var arr = ["김윤서", "김루희", "윤예지", "김혜수", "코코", "민재", "잼권이", "리헤이", "노제", "몬익화", "립제이", "잘린이", "엠마", "모아나", "케이데이", "가비", "시미즈zz", "강호동", "이수근", "유재석", "리정" ]
    
    private var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    private var sectionHeaderList: [String] {
        var sectionHeaderList: [String] = []
        arr = arr.sorted()
        arr.forEach { name in
            sectionHeaderList.append(StringManager.shared.chosungCheck(word: name))
        }
        
        return Array(Set(sectionHeaderList)).sorted()
    }
    
    private var filterdHeaderList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        setLayouts()
        setTableView()
        setRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSearchController()
    }
  
    private func initViewController() {
        title = "연락처"
        view.backgroundColor = .white
    }
    
    private func setRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(tableViewDidPulled(refresh:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.title = "연락처"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTapped))
        
        searchController.searchResultsUpdater = self
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.registerReusableCell(MyCardTableViewCell.self)
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubview(tableView)
    }

    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension ViewController {
    @objc
    private func addButtonDidTapped() {
        let createViewController = CreateViewController()
        let navCreateViewController: UINavigationController = UINavigationController(rootViewController: createViewController)
        present(navCreateViewController, animated: true, completion: nil)
    }
    
    @objc
    private func tableViewDidPulled(refresh: UIRefreshControl) {
        refresh.endRefreshing()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ?  filterdHeaderList.count + 1 : sectionHeaderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ReadViewController(), animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return self.isFiltering ? 0 : 1
        default:
            return self.isFiltering ? getSectionArray(at: section, list: filteredList).count:  getSectionArray(at: section, list: arr).count
        }
    }
    
    func getSectionArray(at section: Int, list: [String]) -> [String] {
        return list.filter {
            return StringManager.shared.chosungCheck(word: $0) == sectionHeaderList[section-1]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MyCardTableViewCell
            return cell
            
        case 1...sectionHeaderList.count:
            let cell = UITableViewCell()
            
            if self.isFiltering {
                cell.textLabel?.text = getSectionArray(at: indexPath.section,list: filteredList)[indexPath.row]
            } else {
                cell.textLabel?.text = getSectionArray(at: indexPath.section,list: arr)[indexPath.row]
            }
            
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            return isFiltering ?  filterdHeaderList[section-1] : sectionHeaderList[section-1]
        } else {
            return nil
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionHeaderList
    }
    
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterdHeaderList.removeAll()
        filteredList.removeAll()
        
        filteredList = arr.filter { $0.localizedCaseInsensitiveContains(text) }
        filteredList.forEach { name in
            filterdHeaderList.append(StringManager.shared.chosungCheck(word: name))
        }
        
        filterdHeaderList = Array(Set(filterdHeaderList)).sorted()
        
        dump(filteredList)
        
        tableView.reloadData()
    }
}
