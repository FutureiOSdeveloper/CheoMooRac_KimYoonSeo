//
//  MyCardTableViewCell.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

class MyCardTableViewCell: UITableViewCell, Reusable {
    
    private let profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .yellow
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "김윤서"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let discriptionLabel = UILabel().then {
        $0.text = "내 카드"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
    }
    
    private let vStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        contentView.addSubviews(profileImageView, vStackView)
        vStackView.addArrangedSubviews(nameLabel,discriptionLabel)
    }

    private func setConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        profileImageView.layer.cornerRadius = 25
        
        vStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).inset(-20)
        }

    }

}
