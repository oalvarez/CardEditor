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
          let index = labels.firstIndex(of: label) else { return }
    viewModel.selectedElementIndex.value = index
  }
  @objc func tapCard(_ sender: UITapGestureRecognizer) {
    //TODO: si todos tienen
    if viewModel.selectedElementIndex.value != nil {
      viewModel.hideFrames()
      viewModel.selectedElementIndex.value = nil
      return
    }
    viewModel.toggleShowFrames()
  }
  
}

extension CardView {
  
  func showFrames(_ show:Bool) {
    labels.forEach {
      $0.text = $0.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    labels.filter {
      $0.text!.isEmpty
      }.forEach {
        if show {
          $0.text!.append(" ")
        }
        $0.showBorder(show)
    }
  }
  
  func updateSelectedLabel() {
    guard let index = viewModel.selectedElementIndex.value else { return }
    underlineLabel(at: index)
    let selectedLabel = labels[index]
    selectedLabel.showBorder(false)
  }
  
  
  //New Stuff
  func popupEmptyElements() {
    popupEmptyLabels()
  }
  func popupEmptyLabels() {
    labels.forEach {
      if $0.text!.isEmpty {
        $0.showBorder(true)
      }
    }
  }
  
  func selectLabel(at index: Int) {
    highlightLabel(at: index)
    underlineLabel(at: index)
  }
  func highlightLabel(at index: Int) {
    labels.forEach {
      $0.textColor = .lightGray
    }
    labels[index].textColor = .white
  }
  func underlineLabel(at index: Int) {
    if labels[index].text!.isEmpty {
      labels[index].text?.append(" ")
    }
    labels[index].underline(true)
  }
  
  func deselectAll() {
    removeHighlights()
    removePopups()
    removeUnderlines()
  }
  func removeHighlights() {
    labels.forEach {
      $0.textColor = .white
    }
  }
  func removePopups() {
    labels.forEach {
      $0.showBorder(false)
    }
  }
  func removeUnderlines() {
    labels.forEach {
      $0.underline(false)
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
        strongSelf.updateSelectedLabel()
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
    
    viewModel.selectedElementIndexObservable
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        guard let index = $0 else {
          strongSelf.deselectAll()
          return
        }
        strongSelf.selectLabel(at: index)
      })
      .disposed(by: bag)
  }
}
