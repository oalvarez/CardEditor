//
//  ElementCard.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 24/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit

class ElementCard: CardView {

  @IBOutlet weak var coverImage: UIImageView!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var backView: UIView!
  
  @IBOutlet weak var title: UITextField!
  @IBOutlet weak var year: UITextField!
  @IBOutlet weak var subtitle: UITextField!
  @IBOutlet weak var overAbout: UITextField!
  @IBOutlet weak var about: UITextView! {
    didSet {
      about.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      about.textContainer.lineFragmentPadding = 0
    }
  }
  @IBOutlet var view: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    view = Bundle.main.loadNibNamed("ElementCard", owner: self, options: nil)?[0] as? UIView
    self.addSubview(view)
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
  }
  
  override var imageViews: [UIImageView] {
    return [
      coverImage,
      iconImage
    ]
  }

  override var fullCardViews: [UIView] {
    return [
      coverImage,
      backView
    ]
  }
  
  override var textFields: [UITextField] {
    return [
      title,
      year,
      subtitle,
      overAbout
    ]
  }
  
}

extension ElementCard {
  func configureFontStyle() {
    title.font = .titleFont
    year.font = .yearFont
    subtitle.font = .subtitleFont
    overAbout.font = .overAboutFont
    about.font = .aboutFont
  }
}
