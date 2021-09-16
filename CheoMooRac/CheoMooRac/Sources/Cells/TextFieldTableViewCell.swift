//
//  TextFieldTableViewCell.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/14.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell,Reusable {
    
    private let textField = UITextField().then {
        $0.borderStyle = .none
        $0.textColor = .black
    }
    
    
    private let seperatorView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    public var placeholder: String? {
        didSet{
            textField.placeholder = placeholder
        }
    }
    
    public var delegate: UITextFieldDelegate? {
        didSet{
            textField.delegate = delegate
        }
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
        contentView.addSubviews(textField, seperatorView)
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
