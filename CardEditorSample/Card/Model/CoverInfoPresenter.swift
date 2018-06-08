//
//  CoverInfoPresenter.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

protocol CoverInfoPresenter {
  var title: String? { get set }
  var subtitle: String? { get set }
  var overDescription: String? { get set }
  var about: String? { get set }
  var year: String? { get set }
  //Will be urls
  var coverImageName: String? { get set }
  var iconImageName: String? { get set }
}
