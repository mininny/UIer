//
//  UIerController.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIView

public class UIerController {
    static let main = UIerController(identifier: "UIer.UIerController.main")
    
    let identifier: String
    var views = WeakObjectSet<UIView>()
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    func addView(_ view: UIView) {
        if !views.contains(view) {
            self.views.addObject(view)
        }
    }
    
    public func setUIerActions(with options: [UIerViewDelegateActions]) {
        self.views.allObjects.forEach { $0.setUIerActions(with: options) }
    }
}

// MARK: - UIGestureRecognizer Actions
extension UIerController {
    @objc func didRecognizeGesture(_ sender: UIGestureRecognizer) {
        if let view = sender.view,
            let delegate = view.uierDelegate,
            view.uierController.identifier == self.identifier {
            switch sender {
            case let tapSender as UITapGestureRecognizer:
                delegate.didTap(view, recognizer: tapSender)
            case let longPressSender as UILongPressGestureRecognizer:
                delegate.didLongPress(view, recognizer: longPressSender)
            case let panSender as UIPanGestureRecognizer:
                delegate.didPan(view, recognizer: panSender)
            case let swipeSender as UISwipeGestureRecognizer:
                delegate.didSwipe(view, recognizer: swipeSender)
            case let rotationSender as UIRotationGestureRecognizer:
                delegate.didRotate(view, recognizer: rotationSender)
            case let pinchSender as UIPinchGestureRecognizer:
                delegate.didPinch(view, recognizer: pinchSender)
            case let screenEdgePanSender as UIScreenEdgePanGestureRecognizer:
                delegate.didScreenEdgePan(view, recognizer: screenEdgePanSender)
            default:
                break
            }
            
            if #available(iOS 13.0, *), let hoverSender = sender as? UIHoverGestureRecognizer {
                delegate.didHover(view, recognizer: hoverSender)
            }
            
            delegate.didRecognizeGesture(view, recognizer: sender)
        }
    }
}
