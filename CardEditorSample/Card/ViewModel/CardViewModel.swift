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
  
  internal var cardInfo: Variable<CoverInfoPresenter>
  internal var card: Variable<CardPresenter>
  internal var showFrames = Variable<Bool>(false)
  
  var selectedImageIndex: Int = -1
  
  init(with card: CardPresenter, cardInfo: CoverInfoPresenter) {
    self.card = Variable<CardPresenter>(card)
    self.cardInfo = Variable<CoverInfoPresenter>(cardInfo)
  }
}

extension CardViewModel: CardViewModelProtocol { }
