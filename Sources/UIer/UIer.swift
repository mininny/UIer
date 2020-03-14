import UIKit

public extension UIView {
    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }

    
    @IBInspectable
    public var borderWidth: CGFloat
    {
        set (width) {
            self.layer.borderWidth = width
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor
    {
        set (color) {
            self.layer.borderColor = color.cgColor
        }
        
        get {
            guard let color = self.layer.borderColor else { return .black }
            return UIColor(cgColor: color)
        }
    }

    
    @IBInspectable
    public var bgHexColor: String?
    {
        set (hexString) {
            guard let str = hexString else { return }
            self.backgroundColor = UIColor.hexStringToUIColor(hex: str)
        }
        
        get {
            return self.backgroundColor?.toHexString()
        }
    }
}
