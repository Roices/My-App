//
//  NavBarHome.swift
//  CleanArchitecture
//
//  Created by Tuan on 14/05/2023.
//  Copyright © 2023 Sun Asterisk. All rights reserved.
//

import UIKit

final class NavBarHome: BaseView {
    // MARK: - IBOutlet
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var btnLanguage: UIButton!
    @IBOutlet private weak var btnLocation: UIButton!
    @IBOutlet private weak var btnLogin: GradientButton!
    
    override func commonInit() {
        _ = fromNib()
        setupView()
    }

    private func setupView() {
        contentView.backgroundColor = UIColor(hexString: AppColor.Surface.fade.rawValue)
        btnLanguage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)// AppFont.font(type: .Bold, size: 14)
        btnLocation.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 14)//AppFont.font(type: .Bold, size: 14)
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)//AppFont.font(type: .Bold, size: 14)
    }
    
    public func setLocationTitle(_ loc: String) {
        btnLocation.setTitle(loc, for: .normal)
    }
    
    public func setLanguageTitle(_ lan: String) {
        btnLocation.setTitle(lan, for: .normal)
    }
    
    public func setButtonLoginTitle(_ title: String) {
        btnLocation.setTitle(title, for: .normal)
    }
}
