//
//  CardViewModelProtocol.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 13/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

protocol CardViewModelProtocol {
  var card: Variable<Card> { get set }
  var cardInfo: Variable<CardInfo> { get set }
  var showFrames: Variable<Bool> { get }
  var selectedImageIndex: Int { get set }
  
  init(with card: Card, cardInfo: CardInfo)
  var cardInfoObservable: Observable<CardInfo> { get }
  var cardObservable: Observable<Card> { get }
  var showFramesObservable: Observable<Bool> { get }
  func hideFrames()
  func toggleShowFrames()
  mutating func incrementSelectedImageIndex()
  func updateSelectedImageName(with text: String)
  func upateCornerRadius(with radius: CGFloat)
  func upateShadow(with shadow: Bool)
  func string(at index: Int) -> String
  
}

extension CardViewModelProtocol {
  
  var cardObservable: Observable<Card> { return card.asObservable() }
  var cardInfoObservable: Observable<CardInfo> { return cardInfo.asObservable() }
  var showFramesObservable: Observable<Bool> { return showFrames.asObservable() }
  
  func updateSelectedImageName(with text: String) {
    guard 0..<cardInfo.value.imageNames.count ~= selectedImageIndex
      else { return }
    cardInfo.value.imageNames[selectedImageIndex] = text
  }
  
  func upateCornerRadius(with radius: CGFloat) {
    card.value.radius = radius
  }
  
  func upateShadow(with shadow: Bool) {
    card.value.shadow = shadow
  }
  
  func updateElement(at index: Int, with text: String) {
    cardInfo.value.infoTexts[index] = text
  }
  
  mutating func incrementSelectedImageIndex() {
    selectedImageIndex += 1
  }
  
  func hideFrames() {
    showFrames.value = false
  }
  
  func toggleShowFrames() {
    showFrames.value.toggle()
  }
  
  func string(at index: Int) -> String {
    return cardInfo.value.infoTexts[index]
  }
}
