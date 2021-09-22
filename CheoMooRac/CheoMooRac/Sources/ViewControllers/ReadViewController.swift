//
//  ReadViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/15.
//

import UIKit

import Then
import SnapKit

class ReadViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let data = [["김윤서","010-7777-7777"],["메시지 보내기", "연락처 공유", "전화걸기", "페이스타임 하기"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        setLayout()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func initViewController() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
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

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableHeaderFooterView(ProfileHeaderView.self)
    }

}

extension ReadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView() as ProfileHeaderView
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        
        if indexPath.section == 1 {
            cell.textLabel?.textColor = .systemBlue
        }
        return cell
    }
    
    
}
