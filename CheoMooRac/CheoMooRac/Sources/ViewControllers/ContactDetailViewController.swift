//
//  ReadViewController.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/15.
//

import UIKit

import Then
import SnapKit

class ContactDetailViewController: UIViewController {

    private var tableViewController: ContactDetailTableViewController!

    init(with viewModel: ContactDetailViewModel) {
        tableViewController = ContactDetailTableViewController(with: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        setLayout()
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
        embed(tableViewController)
        view.addSubview(tableViewController.view)
    }
    
    private func setConstraints() {
        tableViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
