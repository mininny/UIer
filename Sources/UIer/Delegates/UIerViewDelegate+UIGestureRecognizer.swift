//
//  UIerViewDelegate+UIGestureRecognizer.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/15.
//

import UIKit.UIGestureRecognizer

extension UIGestureRecognizer {
    private struct AssociatedKey {
        static var uierAction = "uierActionKey"
    }

    private var uierAction: ((_ sender: Any) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.uierAction) as? ((Any) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.uierAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func didPerfomUIerAction(_ sender: Any) {
        self.uierAction?(sender)
    }
    
    func registerAction(with action: @escaping ((Any)->Void)) {
        self.uierAction = action
        self.addTarget(self, action: #selector(didPerfomUIerAction(_:)))
    }
}
