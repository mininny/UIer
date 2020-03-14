//
//  UIerViewDelegate.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import UIKit.UIView
import ObjectiveC

public enum UIerViewDelegateOptions {
    case tap(numberOfTaps: Int?)
}

extension UIView {
    private struct AssociatedKey {
        static var delegate: UInt8 = 0
    }

    public var delegate: UIerViewDelegate? {
        get {
            return getAssociatedObject(object: self, associativeKey: &AssociatedKey.delegate)
        }

        set {
            if let value = newValue {
                setAssociatedObject(object: self, value: value, associativeKey: &AssociatedKey.delegate, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    public func setDelegateOptions(with options: [UIerViewDelegateOptions]) {
        for option in options {
            switch option {
            case .tap(let numberOfTaps):
                let tapGestureRecognizer = UITapGestureRecognizer(target: nil, action: #selector(UIView.UIerController.didTapView(sender:)))
                tapGestureRecognizer.numberOfTapsRequired = numberOfTaps ?? 1
                self.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
}

fileprivate extension UIView {
    static let UIerController = UIerView()
}

class UIerView {
    @objc func didTapView(sender: UITapGestureRecognizer) {
        if let view = sender.view, let delegate = view.delegate {
            delegate.didTapView(view)
        }
    }
}

public protocol UIerViewDelegate {
    func didTapView(_ view: UIView)
}
