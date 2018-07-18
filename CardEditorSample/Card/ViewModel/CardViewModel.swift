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
  
  internal var cardInfo: Variable<CardInfo>
  internal var card: Variable<Card>
  internal var showFrames = Variable<Bool>(false)
  
  var selectedImageIndex: Int = -1
  
  init(with card: Card, cardInfo: CardInfo) {
    self.card = Variable<Card>(card)
    self.cardInfo = Variable<CardInfo>(cardInfo)
  }
}

extension CardViewModel: CardWithInfoPresentable { }
