import UIKit

public extension UIView {
  
  public func centerInSuperview(with priority: Float = 1000) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).assign(priority)
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).assign(priority)
  }
  
  public func pinToSuperview(safely: Bool = false, top: CGFloat? = 0, leading: CGFloat? = 0, bottom: CGFloat? = 0, trailing: CGFloat? = 0, priority: Float = 1000) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor, constant: top).assign(priority)
    }
    if let leading = leading {
      leadingAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor, constant: leading).assign(priority)
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor, constant: -bottom).assign(priority)
    }
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor, constant: -trailing).assign(priority)
    }
  }
  
  public func setSizeTo(height: CGFloat? = nil, width: CGFloat? = nil, priority: Float = 1000){
    translatesAutoresizingMaskIntoConstraints = false
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).assign(priority)
    }
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).assign(priority)
    }
  }
  
  public func setSizeToLessThanOrEqualTo(height: CGFloat? = nil, width: CGFloat? = nil, priority: Float = 1000){
    translatesAutoresizingMaskIntoConstraints = false
    if let height = height {
      heightAnchor.constraint(lessThanOrEqualToConstant: height).assign(priority)
    }
    if let width = width {
      widthAnchor.constraint(lessThanOrEqualToConstant: width).assign(priority)
    }
  }
  
  public func setSizeToGreaterThanOrEqualTo(height: CGFloat? = nil, width: CGFloat? = nil, priority: Float = 1000){
    translatesAutoresizingMaskIntoConstraints = false
    if let height = height {
      heightAnchor.constraint(greaterThanOrEqualToConstant: height).assign(priority)
    }
    if let width = width {
      widthAnchor.constraint(greaterThanOrEqualToConstant: width).assign(priority)
    }
  }
  
  //Function to pin giving the anchors to pin to
  typealias YAnchorPadding = (anchor: NSLayoutYAxisAnchor, padding: CGFloat, priority: Float)
  typealias XAnchorPadding = (anchor: NSLayoutXAxisAnchor, padding: CGFloat, priority: Float)
  
  public func pinTo(top: YAnchorPadding? = nil, leading: XAnchorPadding? = nil, bottom: YAnchorPadding? = nil, trailing: XAnchorPadding? = nil) {
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor.constraint(equalTo: top.anchor, constant: top.padding).assign(top.priority)
    }
    if let leading = leading   {
      leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.padding).assign(leading.priority)
    }
    if let bottom = bottom     {
      bottom.anchor.constraint(equalTo: bottomAnchor, constant: bottom.padding).assign(bottom.priority)
    }
    if let trailing = trailing {
      trailing.anchor.constraint(equalTo: trailingAnchor, constant: trailing.padding).assign(trailing.priority)
    }
  }
  
  public func setHeight(equalsTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  public func setWidth(equalsTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  public func setHeight(lessThanOrEqualTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  public func setWidth(lessThanOrEqualTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  public func setHeight(greaterThanOrEqualTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  public func setWidth(greaterThanOrEqualTo dimension: NSLayoutDimension, multipilier: CGFloat = 1, constant: CGFloat = 1, priority: Float = 1000) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: multipilier, constant: constant).assign(priority)
  }
  
  //Podríamos hacer una extensión de Constraint que cambie la prioridad de la constraint. Para eso hay que iniciarla a 999 y no 1000 y luego, desactivar, cambiar, activar
  
  //Need to set the priority of all the constraints
  
  //Multipliers
  
  //Take in consideration every posible property
  
  //UIStackViews
}

extension NSLayoutConstraint {
  func assign(_ priority: Float) {
    self.priority = UILayoutPriority(rawValue: priority)
    self.isActive = true
  }
}
