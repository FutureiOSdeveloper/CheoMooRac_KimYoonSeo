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
    
    private var filteredList: [Person] = []
    private var personList = PersonList.shared.getPersonList()

    private var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    private var sectionHeaderList: [String] {
        // Binary Search
//        let timer = ParkBenchTimer()
//        var sectionHeaderList: [String] = []
//        personList.forEach { person in
//            sectionHeaderList.append(StringManager.shared.chosungCheck(word: person.full))
//        }
//        let sectionHeaderTree = BinarySearchTree<String>(array: Array(Set(sectionHeaderList)))
//        print("The task took \(timer.stop()) seconds.")
//        return sectionHeaderTree.toArray()

        var sectionHeaderList: [String] = []
        personList = personList.sorted()
        personList.forEach { person in
            sectionHeaderList.append(StringManager.shared.chosungCheck(word: person.full))
        }
        sectionHeaderList = Array(Set(sectionHeaderList)).sorted()
        return sectionHeaderList
    }
    
    private var filterdHeaderList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        setLayouts()
        setTableView()
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
        let navCreateViewController = UINavigationController(rootViewController: createViewController)
        present(navCreateViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering
        ? filterdHeaderList.count + 1
        : sectionHeaderList.count + 1
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ReadViewController(), animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        guard section != 0 else {
            return self.isFiltering ? 0 : 1
        }

        dump(filteredList)
        dump(getSectionArray(at: section, list: filteredList).count)

        return self.isFiltering
        ? getSectionArray(at: section, list: filteredList).count
        : getSectionArray(at: section, list: personList).count
    }
    
    func getSectionArray(at section: Int, list: [Person]) -> [Person] {
        return list.filter {
            return isFiltering
            ? StringManager.shared.chosungCheck(word: $0.full) == filterdHeaderList[section-1]
            : StringManager.shared.chosungCheck(word: $0.full) == sectionHeaderList[section-1]
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard indexPath.section != 0 else {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MyCardTableViewCell
            return cell
        }

        let cell = UITableViewCell()

        let text = isFiltering
        ? getSectionArray(at: indexPath.section, list: filteredList)[indexPath.row].full
        : getSectionArray(at: indexPath.section, list: personList)[indexPath.row].full

        cell.textLabel?.text = text

        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {

        guard section != 0 else { return nil }

        return isFiltering
        ? filterdHeaderList[section-1]
        : sectionHeaderList[section-1]
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

        filteredList = personList.filter {
            return StringManager.shared.getStringConsonant(string: $0.full, consonantType: .Initial).contains(text) || $0.full.contains(text)
        }

        filteredList.forEach { person in
            filterdHeaderList.append(StringManager.shared.chosungCheck(word: person.full))
        }

        filterdHeaderList = Array(Set(filterdHeaderList)).quicksort(comparison: { $0 < $1 })

        tableView.reloadData()
    }
}

import CoreFoundation

class ParkBenchTimer {
    let startTime: CFAbsoluteTime
    var endTime: CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration: CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
