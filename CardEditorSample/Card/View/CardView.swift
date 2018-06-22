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

  var labels : [UILabel] { return [] }
  var imageViews : [UIImageView] { return [] }
  var fullCardViews : [UIView] { return [] }
}

protocol Card {
  var labels: [UILabel] { get }
}

extension CardView: Card { }

extension CardView {
  
  func addTapGestureForEdition() {
    let cardTap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
    self.addGestureRecognizer(cardTap)
    
    labels.forEach {
      let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
      $0.addGestureRecognizer(tap)
    }
  }
  
  @objc func tapView(_ sender: UITapGestureRecognizer) {
    viewModel.hideFrames()
    guard let label = sender.view as? UILabel,
      let element = labels.firstIndex(of: label) else { return }
    label.textColor = .lightGray
    viewModel.selectedElementTag.value = element
  }
  @objc func tapCard(_ sender: UITapGestureRecognizer) {
    viewModel.toggleShowFrames()
  }
  
  func showFrames(_ show:Bool) {
    labels.forEach { label in
      label.textColor = .white
      if label.text!.isEmpty {
        if show {
          label.text?.append(" ")
        } else {
          label.text = label.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
      }
      label.borderWith = show ? 1 : 0
      label.borderColor = show ? UIColor.init(white: 1, alpha: 0.5) : .clear
      label.cornerRadius = 3
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
        for (label, text) in zip(strongSelf.labels, cardInfo.infoTexts) {
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
        strongSelf.showFrames($0)
      })
      .disposed(by: bag)
  }
}
