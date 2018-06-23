
import UIKit

public extension UIView {

    public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set(newBorderWidth) { layer.borderWidth = newBorderWidth }
    }
  
    public var borderColor: UIColor? {
        get { return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil }
        set(newBorderColor) { layer.borderColor = newBorderColor?.cgColor }
    }
  
    public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set(newCornerRadius) {
            layer.cornerRadius = newCornerRadius
            layer.masksToBounds = newCornerRadius != 0
        }
    }
  
    public var makeCircular: Bool {
        get { return cornerRadius == min(bounds.width, bounds.height) / 2.0 }
        set {
            cornerRadius = newValue ? min(bounds.width, bounds.height) / 2.0 : 0
        }
    }
  
    public var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set(newShadowOffset) {
            layer.shadowOffset = newShadowOffset
        }
    }
  
    public var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set(newShadowRadius) {
            layer.shadowRadius = newShadowRadius
            layer.masksToBounds = false
        }
    }
  
    public var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set(newShadowOpacity) {
            layer.shadowOpacity = newShadowOpacity
        }
    }
    
    public var withShadow: Bool {
        get { return shadowOpacity > 0 }
        set (shadowed) {
            shadowOffset = shadowed ? CGSize(width: 3, height: 3) : CGSize(width: 0, height: 0)
            shadowRadius = shadowed ? 5 : 0
            shadowOpacity = shadowed ? 0.25 : 0
        }
    }
}


extension UIView {
  func underline(_ underline: Bool) {
    self.subviews.last(where: { $0.tag == 1001 })?.removeFromSuperview()
    if underline {
      let view = UIView()
      view.tag = 1001
      view.backgroundColor = .white
      view.setSizeTo(height: 1)
      self.addSubview(view)
      view.pinToSuperview(top: nil)
    }
  }
  
  func showBorder(_ show: Bool) {
    borderWidth = show ? 1 : 0
    borderColor = show ? UIColor.init(white: 1, alpha: 0.5) : .clear
    cornerRadius = 3
  }
}
