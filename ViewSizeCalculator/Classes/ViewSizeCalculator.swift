// ViewSizeCalculator.swift
//
// Copyright (c) 2015 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public struct ViewSizeCalculator<T: UIView> {
    
    public let sourceView: T
    public let calculateTargetView: UIView
    
    public let width: NSLayoutConstraint
    public let height: NSLayoutConstraint
    
    public init(sourceView: T, @noescape calculateTargetView: (T) -> UIView) {
        
        self.sourceView = sourceView
        self.calculateTargetView = calculateTargetView(sourceView)
        
        self.width = NSLayoutConstraint(
            item: self.calculateTargetView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 0,
            constant: 0
        )
        
        self.height = NSLayoutConstraint(
            item: self.calculateTargetView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 0,
            constant: 0
        )
        
        NSLayoutConstraint.activateConstraints([self.width, self.height])
        
        self.height.active = false
    }
    
    public func calculate(@noescape closure: (T) -> Void) -> CGSize {
        
        closure(sourceView)
        
        return calculateTargetView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    }
}