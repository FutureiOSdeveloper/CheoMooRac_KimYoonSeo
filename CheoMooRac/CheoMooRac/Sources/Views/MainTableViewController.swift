//
//  MainTableViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var viewModel: MainViewModelProtocol
    
    private var isFiltering: Bool?
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setTableView()
        setRefreshControl()
    }
    
    private func setTableView() {
        tableView.registerReusableCell(MyCardTableViewCell.self)
    }
    
    private func bindViewModel() {
        viewModel.list.bind { [weak self] _ in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.isFiltering.bind { [weak self] _ in
            guard let self = self else {return}
            self.isFiltering = self.viewModel.isFiltering.value
        }
        
        
        viewModel.nowRefreshing.bind { [weak self] _ in
            guard let self = self else {return}
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func setRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(tableViewDidPulled(refresh:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
}

extension MainTableViewController {
    @objc
    private func tableViewDidPulled(refresh: UIRefreshControl) {
        viewModel.refreshTableView()
    }
}

extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionHeaderList.count + 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ReadViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
}

extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let isFiltering = isFiltering else {return 1}
            return isFiltering ? 0 : 1
        default:
            return viewModel.getSectionArray(at: section).count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MyCardTableViewCell
            return cell
            
        case 1...viewModel.sectionHeaderList.count:
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.getSectionArray(at: indexPath.section)[indexPath.row]
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            return viewModel.sectionHeaderList[section - 1]
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionHeaderList
    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchResults(text: text)
    }
}

extension MainTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
    }
}
