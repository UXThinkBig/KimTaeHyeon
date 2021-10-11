//
//  UsageViewController.swift
//  UXTTextField
//
//  Created by taehy.k on 2021/10/11.
//

import UIKit

import Then
import SnapKit

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}

class UsageViewController: UIViewController {
    // MARK: - UI Components
    
    var descriptionTitleLabel = UILabel().then {
        $0.text = "Usage"
        $0.font = UIFont.systemFont(ofSize: 44, weight: .bold)
    }
    
    lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.addArrangedSubviews(defaultTextLabel, defaultTextField,
                               withChangedBorderColorTextLabel, withChangedBorderColorTextField,
                               withJustTitleTextLabel, withJustTitleTextField)
    }
    
    var defaultTextLabel = UILabel().then {
        $0.text = "📍 디폴트 라벨입니다."
    }
    
    var withChangedBorderColorTextLabel = UILabel().then {
        $0.text = "📍 테두리 색상을 변경할 수 있습니다."
    }
    
    var withJustTitleTextLabel = UILabel().then {
        $0.text = "📍 타이틀만 있는 경우도 만들 수 있습니다."
    }
    
    var defaultTextField = BaeminStyleTextField()
    
    var withChangedBorderColorTextField = BaeminStyleTextField().then {
        $0.activeBorderColor = .systemMint
        $0.inactiveBorderColor = .systemGray
        $0.titleText = "주소 별명 입력"
        $0.placeholderText = "예) 학교, 배달이네 집"
    }
    
    var withJustTitleTextField = BaeminStyleTextField().then {
        $0.titleText = "타이틀만 있는 텍스트 필드"
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        setupLayout()
    }
    
    // MARK: - Overriding
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Setup
    
    private func setupAttributes() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        for view in textFieldStackView.arrangedSubviews {
            view.snp.makeConstraints { $0.height.equalTo(50) }
        }
        
        textFieldStackView.setCustomSpacing(0, after: defaultTextLabel)
        textFieldStackView.setCustomSpacing(0, after: withChangedBorderColorTextLabel)
        textFieldStackView.setCustomSpacing(0, after: withJustTitleTextLabel)
        
        view.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(textFieldStackView)
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().inset(24)
        }
    }
    
    
}
