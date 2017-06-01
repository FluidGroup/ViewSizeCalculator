//
//  ViewSizeCalculator+Cell.swift
//  ViewSizeCalculator
//
//  Created by muukii on 6/1/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import UIKit

extension ViewSizeCalculator where T : UITableViewCell {
  
  public convenience init(sourceView: T) {
    self.init(sourceView: sourceView, calculateTargetView: { $0.contentView })
  }
}

extension ViewSizeCalculator where T : UICollectionViewCell {
  
  public convenience init(sourceView: T) {
    self.init(sourceView: sourceView, calculateTargetView: { $0.contentView })
  }
}
