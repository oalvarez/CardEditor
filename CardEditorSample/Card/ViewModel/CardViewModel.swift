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
  
  var title: String { return cardInfo.value.title ?? ""}
  
  //Update Active Element With para evitar duplicaciones de código
  //Y tener el active element seleccionado que yo quiera tener
  func updateTitle(with text: String) {
    cardInfo.value.title = text
  }
  
  func updateSubtitle(with text: String) {
    cardInfo.value.subtitle = text
  }
  
  func updateYear(with text: String) {
    cardInfo.value.year = text
  }
  
  func updateOverAbout(with text: String) {
    cardInfo.value.overDescription = text
  }
  
  func updateAbout(with text: String) {
    cardInfo.value.about = text
  }
  
  func upateCornerRadius(with radius: CGFloat) {
    card.value.radius = radius
  }
  
  func upateShadow(with shadow: Bool) {
    card.value.shadow = shadow
  }
}
