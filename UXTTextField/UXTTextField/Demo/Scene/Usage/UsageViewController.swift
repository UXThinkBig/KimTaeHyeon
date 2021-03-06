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
        $0.text = "π λν΄νΈ λΌλ²¨μλλ€."
    }
    
    var withChangedBorderColorTextLabel = UILabel().then {
        $0.text = "π νλλ¦¬ μμμ λ³κ²½ν  μ μμ΅λλ€."
    }
    
    var withJustTitleTextLabel = UILabel().then {
        $0.text = "π νμ΄νλ§ μλ κ²½μ°λ λ§λ€ μ μμ΅λλ€."
    }
    
    var defaultTextField = BaeminStyleTextField()
    
    var withChangedBorderColorTextField = BaeminStyleTextField().then {
        $0.activeBorderColor = .systemMint
        $0.inactiveBorderColor = .systemGray
        $0.titleText = "μ£Όμ λ³λͺ μλ ₯"
        $0.placeholderText = "μ) νκ΅, λ°°λ¬μ΄λ€ μ§"
    }
    
    var withJustTitleTextField = BaeminStyleTextField().then {
        $0.titleText = "νμ΄νλ§ μλ νμ€νΈ νλ"
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
