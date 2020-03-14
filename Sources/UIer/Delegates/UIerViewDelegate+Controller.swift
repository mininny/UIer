//
//  UIerViewDelegate+Controller.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIView

extension UIView {
    private struct AssociatedKey {
        static var uierDelegate: UInt8 = 0
        static var uierController: UInt8 = 1
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
        if let identifier = identifier {
            self.uierController = UIerController(identifier: identifier)
        } else {
            self.uierController = .main
        }
        
        self.uierDelegate = delegate
        self.uierController.addView(self)
        
        return self.uierController
    }
    
    public func setUIerActions(with options: [UIerViewDelegateActions]) {
        for option in options {
            switch option {
            case .tap(let numberOfTaps):
                let tapGestureRecognizer = UITapGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                tapGestureRecognizer.numberOfTapsRequired = numberOfTaps
                self.addGestureRecognizer(tapGestureRecognizer)
            case .longPress(let minimumPressDuration, let numberOfTouches, let allowableMovement):
                let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                longPressGestureRecognizer.minimumPressDuration = minimumPressDuration
                longPressGestureRecognizer.numberOfTouchesRequired = numberOfTouches
                longPressGestureRecognizer.allowableMovement = allowableMovement
                self.addGestureRecognizer(longPressGestureRecognizer)
            case .pan(let maxTouch, let minTouch):
                let panGestureRecognizer = UIPanGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                panGestureRecognizer.maximumNumberOfTouches = maxTouch
                panGestureRecognizer.minimumNumberOfTouches = minTouch
                self.addGestureRecognizer(panGestureRecognizer)
            case .hover:
                if #available(iOS 13.0, *){
                    let hoverGestureRecognizer = UIHoverGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                    self.addGestureRecognizer(hoverGestureRecognizer)
                }
            case .swipe(let direction, let numberOfTouches):
                let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                swipeGestureRecognizer.direction = direction
                swipeGestureRecognizer.numberOfTouchesRequired = numberOfTouches
                self.addGestureRecognizer(swipeGestureRecognizer)
            case .rotation:
                let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                self.addGestureRecognizer(rotationGestureRecognizer)
            case .pinch:
                let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                self.addGestureRecognizer(pinchGestureRecognizer)
            case .screenEdgePan(let edges):
                let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self.uierController, action: #selector(self.uierController.didRecognizeGesture))
                screenEdgePanGestureRecognizer.edges = edges
                self.addGestureRecognizer(screenEdgePanGestureRecognizer)
            }
        }
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
