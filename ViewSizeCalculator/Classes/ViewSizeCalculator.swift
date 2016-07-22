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
    public let cache: NSCache = NSCache()
    
    private let widthConstraint: NSLayoutConstraint
    private let heightConstraint: NSLayoutConstraint
    
    public init(sourceView: T, @noescape calculateTargetView: (T) -> UIView) {
        
        self.sourceView = sourceView
        self.calculateTargetView = calculateTargetView(sourceView)
        
        self.widthConstraint = NSLayoutConstraint(
            item: self.calculateTargetView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 0,
            constant: 0
        )
        
        self.heightConstraint = NSLayoutConstraint(
            item: self.calculateTargetView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 0,
            constant: 0
        )
    }
    
    public func calculate(
        width width: CGFloat?,
        height: CGFloat?,
        cacheKey: String,
        @noescape closure: (T) -> Void) -> CGSize {
        
        let combinedCacheKey = cacheKey + "|" + "\(width):\(height)"
        
        if let size = (cache.objectForKey(combinedCacheKey) as? NSValue)?.CGSizeValue() {
            return size
        }
        
        if let width = width {
            widthConstraint.active = true
            widthConstraint.constant = width
        }
        else {
            widthConstraint.active = false
        }
        
        if let height = height {
            heightConstraint.active = true
            heightConstraint.constant = height
        }
        else {
            heightConstraint.active = false
        }
        
        closure(sourceView)
        
        let size = calculateTargetView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        cache.setObject(NSValue(CGSize: size), forKey: combinedCacheKey)
        
        return size
    }
}