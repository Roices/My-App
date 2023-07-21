//
//  BaseView.swift
//  CleanArchitecture
//
//  Created by Tuan on 14/05/2023.
//  Copyright © 2023 Sun Asterisk. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        
    }
}
