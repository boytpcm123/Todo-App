//
//  CustomNavigationBar.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa

class CustomNavigationBar: UIView {
    
    // MARK: - OUTLET
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rightButton: UIButton!
    
    // MARK: - PROPERTIES
    var onLeftButtonAction: () -> Void = {}
    var onRightButtonAction: () -> Void = {}
    private let disposeBag = DisposeBag()
    
    // MARK: - CONSTRUCTORS
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if self.subviews.isEmpty {
            self.commonInit()
        }
    }
}

// MARK: - CONFIG
extension CustomNavigationBar {
    
    private func commonInit() {
        setupUI()
        bindLeftButton()
        bindRightButton()
    }
    
    private func setupUI() {
        
        let nib = UINib(nibName: "CustomNavigationBar", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    private func bindLeftButton() {
        
        leftButton.accessibilityIdentifier = "leftButton"
        leftButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.onLeftButtonAction()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindRightButton() {
        rightButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.onRightButtonAction()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - PUBLIC METHOD
extension CustomNavigationBar {
    
    public var title: String {
        get {
            self.titleLabel.text ?? ""
        }
        set {
            self.titleLabel.text = newValue
        }
    }
}
