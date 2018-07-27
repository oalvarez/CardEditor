//
//  CardModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import CoreGraphics

struct CardModel: Card {
  var roundedCorners: (topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool)? = nil //(true, false, false, false)
  var radius: CGFloat = 10
  var shadow: Bool = true
  var size: CGSize = CGSize(width: 350, height: 225)
}
