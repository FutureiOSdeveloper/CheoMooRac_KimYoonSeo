//
//  ProfileHeaderView.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView, Reusable {
    
    private let profileButton = UIButton().then {
        $0.setBackgroundColor(.black, for: .normal)
        $0.clipsToBounds = true
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder doesn't exist")
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        contentView.addSubview(profileButton)
    }
    
    private func setConstraints() {
        
        profileButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        profileButton.layer.cornerRadius = 50
        
     
    }
    
}
