//
//  CardViewModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

struct CardViewModel {
  private var card: Variable<CardPresenter>
  private var cardInfo: Variable<CoverInfoPresenter>
  var cardInfoObservable: Observable<CoverInfoPresenter> {
    return cardInfo.asObservable()
  }
  var cardObservable: Observable<CardPresenter> {
    return card.asObservable()
  }
  
  init(with card: CardPresenter, cardInfo: CoverInfoPresenter) {
    self.card = Variable<CardPresenter>(card)
    self.cardInfo = Variable<CoverInfoPresenter>(cardInfo)
  }
  
  var title: String { return cardInfo.value.infoTexts.first ?? ""}
  var selectedElementTag = Variable<Int>(0)
  var selectedElementTagObservable: Observable<Int> {
    return selectedElementTag.asObservable()
  }
  
  func updateActiveLabel(with text: String) {
    let index = selectedElementTag.value
    updateElement(at: index, with: text)
  }
  
  func string(at index: Int) -> String {
    return cardInfo.value.infoTexts[index]
  }
  
  private var showFrames = Variable<Bool>(false)
  func hideFrames() { showFrames.value = false }
  func toggleShowFrames() { showFrames.value.toggle() }
  var showFramesObservable: Observable<Bool> {
    return showFrames.asObservable()
  }
  
  func updateElement(at index: Int, with text: String) {
    cardInfo.value.infoTexts[index] = text
  }
  
  func upateCornerRadius(with radius: CGFloat) {
    card.value.radius = radius
  }
  
  func upateShadow(with shadow: Bool) {
    card.value.shadow = shadow
  }
}
