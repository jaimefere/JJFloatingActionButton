//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 21.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

/// A colored circle with an highlighted state
///
@objc @IBDesignable open class JJCircleView: UIView {

    /// The color of the circle.
    ///
    @objc @IBInspectable open var color: UIColor = JJStyles.defaultButtonColor {
        didSet {
            updateHighlightedColorFallback()
            setNeedsDisplay()
        }
    }

    /// The color of the circle when highlighted. Default is `nil`.
    ///
    @objc @IBInspectable open var highlightedColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    /// A Boolean value indicating whether the circle view draws a highlight.
    /// Default is `false`.
    ///
    @objc open var isHighlighted = false {
        didSet {
            setNeedsDisplay()
        }
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    ///
    /// - Returns: `self`, initialized using the data in decoder.
    ///
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    /// Draws the receiver’s image within the passed-in rectangle
    /// Overrides `draw(rect: CGRect)` from `UIView`.
    ///
    open override func draw(_: CGRect) {
        drawCircle(inRect: bounds)
    }

    fileprivate var highlightedColorFallback = JJStyles.defaultHighlightedButtonColor
}

// MARK: - Private Methods

fileprivate extension JJCircleView {

    func setup() {
        backgroundColor = .clear
    }

    func drawCircle(inRect rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        let diameter = min(rect.width, rect.height)
        var circleRect = CGRect()
        circleRect.size.width = diameter
        circleRect.size.height = diameter
        circleRect.origin.x = (rect.width - diameter) / 2
        circleRect.origin.y = (rect.height - diameter) / 2

        let circlePath = UIBezierPath(ovalIn: circleRect)
        currentColor.setFill()
        circlePath.fill()

        context.restoreGState()
    }

    var currentColor: UIColor {
        if !isHighlighted {
            return color
        }

        if let highlightedColor = highlightedColor {
            return highlightedColor
        }

        return highlightedColorFallback
    }

    func updateHighlightedColorFallback() {
        highlightedColorFallback = color.highlighted
    }
}