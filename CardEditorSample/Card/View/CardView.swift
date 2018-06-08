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

  let bag = DisposeBag()
  var viewModel: CardViewModel!
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
    self.viewModel = viewModel
    
    configureObservables()
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

extension CardView {
  func configureObservables() {
    viewModel.cardInfoObservable
      .subscribe(onNext: { cardInfo in
        print("Card Info: \(cardInfo)")
        self.title.text = cardInfo.title
        self.year.text = cardInfo.year
        self.subtitle.text = cardInfo.subtitle
        self.noteOverDescription.text = cardInfo.overDescription
        self.about.text = cardInfo.about
        
        self.coverImage.image = UIImage(named: cardInfo.coverImageName!)
        self.iconImage.image = UIImage(named: cardInfo.iconImageName!)
      })
    .disposed(by: bag)
    
    viewModel.cardObservable
      .subscribe(onNext: { card in
        self.coverImage.cornerRadius = card.radius
        self.backView.cornerRadius = card.radius
        self.withShadow = card.shadow
      })
    .disposed(by: bag)
  }
}
extension CardView : CardPresentable { }
