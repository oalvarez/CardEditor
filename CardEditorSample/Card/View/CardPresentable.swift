//
//  CardPresentable.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit

protocol CardPresentable {
  var coverImage: UIImageView! { get }
  var backView: UIView! { get }
}

protocol CoverDataPresentable {
  var title: UILabel! { get }
  var subtitle: UILabel! { get }
  var overDescription: UILabel! { get }
  var description: UILabel! { get }
  var year: UILabel! { get }
}
