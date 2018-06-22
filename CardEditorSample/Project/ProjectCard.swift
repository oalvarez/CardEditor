//
//  ProjectCard.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 21/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit

class ProjectCard: CardView {

  @IBOutlet weak var backView: UIView!
  
  //DataPresentableProperties
  @IBOutlet weak var coverImage: UIImageView!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var year: UILabel!
  @IBOutlet weak var subtitle: UILabel!
  @IBOutlet weak var noteOverDescription: UILabel!
  
  @IBOutlet weak var about: UILabel!
  @IBOutlet var view: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    view = Bundle.main.loadNibNamed("ProjectCard", owner: self, options: nil)?[0] as? UIView
    self.addSubview(view)
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
  }
  
  override var labels: [UILabel] {
    return [
      title,
      year,
      subtitle,
      noteOverDescription,
      about
    ]
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

}

extension ProjectCard {
  func configureFontStyle() {
    title.font = .titleFont
    year.font = .yearFont
    subtitle.font = .subtitleFont
    noteOverDescription.font = .overAboutFont
    about.font = .aboutFont
  }
}
