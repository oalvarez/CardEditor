//
//  CoverInfoPresenter.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation

protocol CoverInfoPresenter {
  var title: String? { get set }
  var subtitle: String? { get }
  var overDescription: String? { get }
  var about: String? { get }
  var year: String? { get }
  //Will be urls
  var coverImageName: String? { get }
  var iconImageName: String? { get }
}
