//
//  NibLoaderViewProtocol.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 14/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoaderViewProtocol: class {
  var view: UIView! { get set }
  func loadNibFile()
}

extension NibLoaderViewProtocol where Self: UIView {
  
  func loadNibFile() {
    view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? UIView
    self.addSubview(view)
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
  }
}
