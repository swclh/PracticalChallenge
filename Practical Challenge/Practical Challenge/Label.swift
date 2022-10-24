//
//  CellLabel.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 23/10/22.
//

import UIKit

class Label: UILabel {
    
    // This class should be used in place of UILabel for the UserTableView cells, to avoid code duplication
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("init(coder:) disabled")
    }
}
