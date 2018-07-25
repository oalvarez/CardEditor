//
//  CardModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import CoreGraphics

struct CardModel: Card {
  var radius: CGFloat = 10
  var shadow: Bool = true
  var size: CGSize = CGSize(width: 350, height: 225)
}
