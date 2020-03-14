//
//  UIerViewDelegateActions.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIGestureRecognizer

public enum UIerViewDelegateActions {
    case tap(numberOfTaps: Int = 1)
    case longPress(minimumPressDuration: TimeInterval = 0.5, numberOfTouches: Int = 1, allowableMovement: CGFloat = 10.0)
    case pan(maxTouch: Int = .max, minTouch: Int = 1)
    @available(iOS 13.0, *)
    case hover
    case swipe(direction: UISwipeGestureRecognizer.Direction = .right, numberOfTouches: Int = 1)
    case rotation
    case pinch
    case screenEdgePan(edges: UIRectEdge = UIRectEdge.all)
}

extension UIerViewDelegateActions {
    public static var tap: UIerViewDelegateActions { .tap() }
    public static var longPress: UIerViewDelegateActions { .longPress() }
    public static var pan: UIerViewDelegateActions { .pan() }
    public static var swipe: UIerViewDelegateActions { .swipe() }
    public static var screenEdgePan: UIerViewDelegateActions { .screenEdgePan() }
}
