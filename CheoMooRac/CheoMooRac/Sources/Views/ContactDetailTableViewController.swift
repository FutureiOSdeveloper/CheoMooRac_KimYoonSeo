//
//  ContactDetailTableViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    private var viewModel: ContactDetailViewModel!
    
    private let data = ["메시지 보내기", "연락처 공유", "전화걸기", "페이스타임 하기"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableHeaderFooterView(ProfileHeaderView.self)
    }
    
    init(with viewModel: ContactDetailViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Data Source
extension ContactDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 4
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.items[indexPath.row]
            return cell
            
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textColor = .systemBlue
            return cell
            
        default:
            return UITableViewCell()
        }
       
    }

}

// MARK: - Delegate
extension ContactDetailTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView() as ProfileHeaderView
            return header
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
