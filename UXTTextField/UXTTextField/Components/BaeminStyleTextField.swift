//
//  BaeminStyleTextField.swift
//  UXTTextField
//
//  Created by taehy.k on 2021/10/11.
//

import UIKit

import Then
import SnapKit

class BaeminStyleTextField: UITextField, TextFieldGenerator {
    
    // MARK: - Properties
    
    /// 테두리 두께 (기본값 : 3)
    open var borderSize: CGFloat = 3.0 {
        didSet {
            updateBorder()
        }
    }
    
    /// 활성화 시 테두리 색상 (기본값 :  black)
    open var activeBorderColor: UIColor = .black {
        didSet {
            updateBorder()
        }
    }
    
    /// 비활성화 시 테두리 색상 (기본값 :  systemGray5)
    open var inactiveBorderColor: UIColor = .systemGray5 {
        didSet {
            updateBorder()
        }
    }
    
    /// 테두리 둥근 정도 (기본값 :  5)
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            updateBorder()
        }
    }
    
    open var titleText: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// placeholder 텍스트 (값이 없을 수도 있음)
    open var placeholderText: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// placeholder 색상 (placeholder가 없는 경우, 색상 없을 수 있음)
    open var placeholderColor: UIColor? = .systemGray5 {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// 커서 색상 (기본 색상 : systemMint, 배민 메인 컬러와 유사)
    open var cursorColor: UIColor = .systemMint {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// 텍스트 필드 내부 padding (기본값 :  15)
    open var inset: CGFloat = 15
    private lazy var commonInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    
    /// Clear 버튼 padding은 고정값 사용
    private let clearButtonOffset: CGFloat = 5
    private let clearButtonLeftPadding: CGFloat = 10

    // MARK: - Components
    
    lazy var placeholderLabel = PaddingLabel().then {
        $0.text = titleText
        $0.textColor = .systemGray
        $0.backgroundColor?.withAlphaComponent(0)
    }
    
    // MARK: - Initialize
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefault()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholderText = placeholder
    }

    // MARK: - Setup
    
    private func setupDefault() {
        delegate = self
        setupAttributes()
        updateBorder()
        updatePlaceholder()
    }
    
    private func setupAttributes() {
        self.placeholder = ""
        self.clearButtonMode = .whileEditing
    }
    
    private func setupLayout() {
        self.superview?.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(5)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }

    private func updateBorder() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderSize
        layer.borderColor = isFirstResponder || hasText ? activeBorderColor.cgColor : inactiveBorderColor.cgColor
    }
    
    private func updatePlaceholder() {
        guard let titleText = titleText else { return }
        placeholderLabel.backgroundColor = titleText.isEmpty ? UIColor.clear : .white
        self.placeholder = isFirstResponder ? placeholderText : ""
        self.placeholderLabel.text = titleText
        self.tintColor = cursorColor
    }
    
    // MARK: - Animation
    
    private func animateActiveStateViews() {
        let scale = 0.7
        let translationX = (placeholderLabel.frame.width - placeholderLabel.frame.width * scale) / 2 + 5
        let translationY = frame.height / 2

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            let scale = CGAffineTransform(scaleX: scale, y: scale)
            let move = CGAffineTransform(translationX: -translationX + 5, y: -translationY)
            self?.placeholderLabel.transform = scale.concatenating(move)
        })
    }
    
    private func animateInactiveStateViews() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.placeholderLabel.transform = CGAffineTransform.identity
        })
    }
}

extension BaeminStyleTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorder()
        updatePlaceholder()
        animateActiveStateViews()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBorder()
        updatePlaceholder()
        if !hasText {
            animateInactiveStateViews()
        }
    }
}

// MARK: - Overriding Functions
/**
 좌우 인셋, 클리어 버튼의 인셋 등을 조정하기 위해 오버라이딩
 */
extension BaeminStyleTextField {
    /**
     트러블 슈팅에 사용한 매우 중요한 함수 ⭐️
     */
    override func didMoveToSuperview() {
        setupLayout()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: commonInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: commonInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonWidth = clearButtonRect(forBounds: bounds).width
        let editingInsets = UIEdgeInsets(top: commonInsets.top,
                                         left: commonInsets.left,
                                         bottom: commonInsets.bottom,
                                         right: clearButtonWidth + clearButtonOffset + clearButtonLeftPadding)
        return bounds.inset(by: editingInsets)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var clearButtonRect = super.clearButtonRect(forBounds: bounds)
        clearButtonRect.origin.x -= clearButtonOffset
        return clearButtonRect
    }
}


