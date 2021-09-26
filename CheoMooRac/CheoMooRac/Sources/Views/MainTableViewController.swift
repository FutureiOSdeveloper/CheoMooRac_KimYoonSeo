//
//  MainTableViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import UIKit

import RxSwift
import RxCocoa

class MainTableViewController: UITableViewController {
    
    private var viewModel: MainViewModelProtocol
    
    private var isFiltering: Bool?
    
    private var disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var data: [[Person]] = [[]]
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        bindViewModel()
        setTableView()
        setRefreshControl()
    }
    
    private func setTableView() {
        tableView.registerReusableCell(MyCardTableViewCell.self)
    }
    
    private func bindViewModel() {
        searchController.searchBar.rx.text
            .bind(to: viewModel.input.searchBarText)
            .disposed(by: disposeBag)
        
        viewModel.output.filtering
            .emit(onNext:{ value in
                self.isFiltering = value
            }).disposed(by: disposeBag)
        
        viewModel.output.sectionPeopleArray
            .emit(onNext:{ data in
                self.data.removeAll()
                self.data = data
//
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
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
//        viewModel.input.refreshTableView()
    }
}

// MARK: - Delegate
extension MainTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

//        let person = viewModel.output.getSectionPersonArray(at: indexPath.section)[indexPath.row]
//
//        let contactDetailViewModel = ContactDetailViewModel(person: person)
//        navigationController?.pushViewController(ContactDetailViewController(with: contactDetailViewModel), animated: true)
    }
//
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return 100
//        default:
            return 48
//        }
    }
}

// MARK: - Data Source
extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
//        return data.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
//        switch section {
//        case 0:
//            guard let isFiltering = isFiltering else {return 1}
//            return isFiltering ? 0 : 1
//        default:
//            return data[section-1].count
//        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.section][indexPath.row].familyName + data[indexPath.section][indexPath.row].firstName
        return cell
        
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MyCardTableViewCell
//            return cell
//
//        case 1...data[indexPath.section-1].count:
//            let cell = UITableViewCell()
//            cell.textLabel?.text = data[indexPath.section-1][indexPath.row].familyName + data[indexPath.section-1][indexPath.row].firstName
//            return cell
//
//        default:
//            return UITableViewCell()
//        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
//        if section != 0 {
//            return "ㄱ"
//        } else {
//            return nil
//        }
    }

//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return viewModel.output.sectionHeaderList
//    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
    }
}

extension MainTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        viewModel.input.cancelSearch()
    }
}
