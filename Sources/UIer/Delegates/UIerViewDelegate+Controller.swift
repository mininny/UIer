//
//  UIerViewDelegate+Controller.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIView

extension UIView {
    private struct AssociatedKey {
        static var uierDelegate = "uierDelegateKey"
        static var uierController = "uierControllerKey"
    }
    
    var uierDelegate: UIerViewDelegate? {
        get {
            return getAssociatedObject(object: self, associativeKey: &AssociatedKey.uierDelegate)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(object: self, value: value, associativeKey: &AssociatedKey.uierDelegate, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var uierController: UIerController {
        get {
            return getAssociatedObject(object: self, associativeKey: &AssociatedKey.uierController) ?? .main
        }
        
        set {
            setAssociatedObject(object: self, value: newValue, associativeKey: &AssociatedKey.uierController, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    public func registerUIerDelegate(_ delegate: UIerViewDelegate, identifier: String? = nil) -> UIerController {
        self.uierController = UIerController.controller(for: identifier)
        
        self.uierDelegate = delegate
        self.uierController.addView(self)
        
        return self.uierController
    }
    
    public func setUIerActions(with options: [UIerViewDelegateActions]) {
        for option in options {
            self.addGestureRecognizer(with: option, action: #selector(self.uierController.didRecognizeGesture))
        }
    }
    
    public func addUIerAction(with option: UIerViewDelegateActions, action: @escaping ((_ sender: Any)->Void)) {
        let gestureRecognizer = self.addGestureRecognizer(with: option, action: #selector(self.uierController.didRecognizeGesture))
        gestureRecognizer?.registerAction(with: action)
    }
    
    private func registerGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) -> UIGestureRecognizer{
        self.addGestureRecognizer(gestureRecognizer)
        return gestureRecognizer
    }
    
    @discardableResult
    private func addGestureRecognizer(with option: UIerViewDelegateActions, action: Selector? = nil) -> UIGestureRecognizer? {
        switch option {
        case .tap(let numberOfTaps):
            let tapGestureRecognizer = UITapGestureRecognizer(target: self.uierController, action: action)
            tapGestureRecognizer.numberOfTapsRequired = numberOfTaps
            return self.registerGestureRecognizer(tapGestureRecognizer)
            
        case .longPress(let minimumPressDuration, let numberOfTouches, let allowableMovement):
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self.uierController, action: action)
            longPressGestureRecognizer.minimumPressDuration = minimumPressDuration
            longPressGestureRecognizer.numberOfTouchesRequired = numberOfTouches
            longPressGestureRecognizer.allowableMovement = allowableMovement
            return self.registerGestureRecognizer(longPressGestureRecognizer)
            
        case .pan(let maxTouch, let minTouch):
            let panGestureRecognizer = UIPanGestureRecognizer(target: self.uierController, action: action)
            panGestureRecognizer.maximumNumberOfTouches = maxTouch
            panGestureRecognizer.minimumNumberOfTouches = minTouch
            return self.registerGestureRecognizer(panGestureRecognizer)
            
        case .hover:
            if #available(iOS 13.0, *){
                let hoverGestureRecognizer = UIHoverGestureRecognizer(target: self.uierController, action: action)
                return self.registerGestureRecognizer(hoverGestureRecognizer)
            }
            
        case .swipe(let direction, let numberOfTouches):
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self.uierController, action:action)
            swipeGestureRecognizer.direction = direction
            swipeGestureRecognizer.numberOfTouchesRequired = numberOfTouches
            return self.registerGestureRecognizer(swipeGestureRecognizer)
            
        case .rotation:
            let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self.uierController, action: action)
            return self.registerGestureRecognizer(rotationGestureRecognizer)
            
        case .pinch:
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self.uierController, action: action)
            return self.registerGestureRecognizer(pinchGestureRecognizer)
            
        case .screenEdgePan(let edges):
            let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self.uierController, action: action)
            screenEdgePanGestureRecognizer.edges = edges
            return self.registerGestureRecognizer(screenEdgePanGestureRecognizer)
        }
        return nil
    }
}

extension Array where Element == UIView {
    @discardableResult
    public func registerUIerDelegate(_ delegate: UIerViewDelegate, identifier: String? = nil) -> UIerController? {
        if self.isEmpty { return nil }
        
        for view in self {
            view.registerUIerDelegate(delegate, identifier: identifier)
        }
        
        return self.first?.uierController
    }
}
