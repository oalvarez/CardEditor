//
//  CardWithInfoPresentable.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 13/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

protocol CardWithInfoPresentable: CardPresentable & CardInfoPresentable {
  init(with card: Card, cardInfo: CardInfo)
}
