//
//  CardViewModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation

struct CardViewModel {
  var card: CardPresenter
  var cardInfo: CoverInfoPresenter
  
  mutating func updateTitle(with text: String) {
    cardInfo.title = text
  }
}
