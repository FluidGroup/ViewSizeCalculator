//
//  Cell.swift
//  ViewSizeCalculator
//
//  Created by muukii on 7/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

final class Cell: UITableViewCell {
    
    func update(item item: ViewController.Item) {
        titleLabel.text = item.title
        messageLabel.text = item.message
    }
        
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
}
