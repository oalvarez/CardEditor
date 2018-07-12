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
  
  private var cardInfo: Variable<CoverInfoPresenter>
  var cardInfoObservable: Observable<CoverInfoPresenter> {
    return cardInfo.asObservable()
  }
  private var card: Variable<CardPresenter>
  var cardObservable: Observable<CardPresenter> {
    return card.asObservable()
  }
  
  init(with card: CardPresenter, cardInfo: CoverInfoPresenter) {
    self.card = Variable<CardPresenter>(card)
    self.cardInfo = Variable<CoverInfoPresenter>(cardInfo)
  }
  
  var title: String { return cardInfo.value.infoTexts.first ?? ""}
  
  func string(at index: Int) -> String {
    return cardInfo.value.infoTexts[index]
  }
  
  private var showFrames = Variable<Bool>(false)
  func hideFrames() { showFrames.value = false }
  func toggleShowFrames() { showFrames.value.toggle() }
  var showFramesObservable: Observable<Bool> {
    return showFrames.asObservable()
  }
  
  var selectedImageIndex: Int = -1
  mutating func incrementSelectedImageIndex() {
    selectedImageIndex += 1
  }
  
  func updateSelectedImageName(with text: String) {
    guard 0..<cardInfo.value.imageNames.count ~= selectedImageIndex
     else { return }
    cardInfo.value.imageNames[selectedImageIndex] = text
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
