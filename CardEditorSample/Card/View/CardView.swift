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

  var textFields: [UITextField] { return [] }
  var imageViews : [UIImageView] { return [] }
  var fullCardViews : [UIView] { return [] }
}

extension CardView {
  var selectedTextField: UITextField? {
    return textFields.first(where: { $0.isFirstResponder } )
  }
}

extension CardView {
  
  func addTapGestureForEdition() {
    let cardTap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
    self.addGestureRecognizer(cardTap)
  }

  @objc func tapCard(_ sender: UITapGestureRecognizer) {
    viewModel.toggleShowFrames()
  }
  
}

extension CardView {
  
  func showEmptyFields(_ show:Bool) {
    textFields.forEach {
      $0.isHidden = $0.text!.isEmpty ? !show : false
    }
  }
  
  func showPopulatedFields(_ show:Bool) {
    textFields.forEach {
      $0.isHidden = $0.text!.isEmpty ? true : !show
    }
  }
  
  func prepareFieldsForEdition(_ edition: Bool) {
    textFields.forEach {
      $0.isUserInteractionEnabled = edition
    }
  }
}

//MARK - Configuration of the Card
extension CardView {
  func configureCard(with viewModel: CardViewModel) {
    self.viewModel = viewModel
    configureObservables()
  }
  func configureCardForEdition() {
    addTapGestureForEdition()
  }
}

extension CardView {
  func configureObservables() {
    viewModel.cardInfoObservable
      .subscribe(onNext: { [weak self] cardInfo in
        guard let strongSelf = self else { return }
        for (label, text) in zip(strongSelf.textFields, cardInfo.infoTexts) {
          label.text = text
        }
        for (imageView, name) in zip(strongSelf.imageViews, cardInfo.imageNames) {
          imageView.image = UIImage(named: name)
        }
      })
    .disposed(by: bag)
    
    viewModel.cardObservable
      .subscribe(onNext: { [weak self] card in
        guard let strongSelf = self else { return }
        strongSelf.fullCardViews.forEach {
          $0.cornerRadius = card.radius
        }
        strongSelf.withShadow = card.shadow
      })
    .disposed(by: bag)
    
    viewModel.showFramesObservable
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.showEmptyFields($0)
      })
      .disposed(by: bag)
  }
}
