//
//  CardView.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit
import RxSwift

class CardView: UIView {

  //CardPresentable Properties
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
    view = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?[0] as? UIView
    self.addSubview(view)
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self.view]))
  }
}

extension CardView {
  func configureCard(with viewModel: CardViewModel) {
    
    coverImage.cornerRadius = viewModel.card.radius
    backView.cornerRadius = viewModel.card.radius
    withShadow = viewModel.card.shadow
    
    title.text = viewModel.cardInfo.title
    year.text = viewModel.cardInfo.year
    subtitle.text = viewModel.cardInfo.subtitle
    noteOverDescription.text = viewModel.cardInfo.overDescription
    about.text = viewModel.cardInfo.about
    
    coverImage.image = UIImage(named: viewModel.cardInfo.coverImageName!)
    iconImage.image = UIImage(named: viewModel.cardInfo.iconImageName!)
    
    configureFontStyle()
  }
  
  func configureFontStyle() {
    title.font = .titleFont
    year.font = .yearFont
    subtitle.font = .subtitleFont
    noteOverDescription.font = .overAboutFont
    about.font = .aboutFont
  }
}

extension CardView : CardPresentable { }
