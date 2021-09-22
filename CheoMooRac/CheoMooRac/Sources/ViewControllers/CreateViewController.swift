//
//  CreateViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

enum Placeholder: Int {
    case familyName = 0
    case name
    case number
    
    var text: String {
        switch self {
        case .familyName:
            return "성"
        case .name:
            return "이름"
        case .number:
            return "전화번호"
        }
    }
}

class CreateViewController: UIViewController {
    
    private let tableView = UITableView().then {
        $0.sectionHeaderHeight = 140
        $0.rowHeight = 40
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
        
        setLayouts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.registerReusableHeaderFooterView(ProfileHeaderView.self)
        tableView.registerReusableCell(TextFieldTableViewCell.self)
    }
    
    
    private func setNavigationBar() {
        title = "새로운 연락처"
      
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonDidTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonDidTapped))
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

extension CreateViewController {
    @objc
    func cancelButtonDidTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func completeButtonDidTapped(){
        dismiss(animated: true, completion: nil)
    }
}

extension CreateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView() as ProfileHeaderView
            return header
        default:
            return nil
        }
    }
}

extension CreateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as TextFieldTableViewCell
            cell.placeholder = Placeholder.init(rawValue: indexPath.row)?.text
            cell.textFieldDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension CreateViewController: UITextFieldDelegate {
    
}
