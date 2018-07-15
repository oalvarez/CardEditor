//
//  Card.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import CoreGraphics

protocol Card {
  var radius: CGFloat { get set }
  var shadow: Bool { get set }
  var size: CGSize { get set }
}
