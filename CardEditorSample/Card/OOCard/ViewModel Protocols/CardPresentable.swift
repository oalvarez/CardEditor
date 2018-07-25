//
//  CardPresentable.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 15/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import RxSwift

protocol CardPresentable {
  var card: Variable<Card> { get set }
  
  var cardObservable: Observable<Card> { get }
  
  func upateCornerRadius(with radius: CGFloat)
  func upateShadow(with shadow: Bool)
}

extension CardPresentable {
  var cardObservable: Observable<Card> { return card.asObservable() }
  
  func upateCornerRadius(with radius: CGFloat) {
    card.value.radius = radius
  }
  
  func upateShadow(with shadow: Bool) {
    card.value.shadow = shadow
  }
}
