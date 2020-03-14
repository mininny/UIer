//
//  UIerViewDelegate.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIView
import ObjectiveC

public protocol UIerViewDelegate {
    func didTap(_ view: UIView, recognizer: UITapGestureRecognizer)
    
    func didLongPress(_ view: UIView, recognizer: UILongPressGestureRecognizer)
    
    func didPan(_ view: UIView, recognizer: UIPanGestureRecognizer)
    
    @available(iOS 13.0, *)
    func didHover(_ view: UIView, recognizer: UIHoverGestureRecognizer)
    
    func didSwipe(_ view: UIView, recognizer: UISwipeGestureRecognizer)
    
    func didRotate(_ view: UIView, recognizer: UIRotationGestureRecognizer)
    
    func didPinch(_ view: UIView, recognizer: UIPinchGestureRecognizer)
    
    func didScreenEdgePan(_ view: UIView, recognizer: UIScreenEdgePanGestureRecognizer)
    
    func didRecognizeGesture(_ view: UIView, recognizer: UIGestureRecognizer)
}

public extension UIerViewDelegate {
    func didTap(_ view: UIView, recognizer: UITapGestureRecognizer) { }
    
    func didLongPress(_ view: UIView, recognizer: UILongPressGestureRecognizer) { }
    
    func didPan(_ view: UIView, recognizer: UIPanGestureRecognizer) { }
 
    @available(iOS 13.0, *)
    func didHover(_ view: UIView, recognizer: UIHoverGestureRecognizer) { }
    
    func didSwipe(_ view: UIView, recognizer: UISwipeGestureRecognizer) { }
    
    func didRotate(_ view: UIView, recognizer: UIRotationGestureRecognizer) { }
    
    func didPinch(_ view: UIView, recognizer: UIPinchGestureRecognizer) { }
    
    func didScreenEdgePan(_ view: UIView, recognizer: UIScreenEdgePanGestureRecognizer) { }
    
    func didRecognizeGesture(_ view: UIView, recognizer: UIGestureRecognizer) { }
}
