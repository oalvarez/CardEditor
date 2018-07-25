//
//  CardInfo.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

protocol CardInfo {
  var textViewsInfo: [String] { get set }
  var textFieldsInfo: [String] { get set }
  var imageNames: [String] { get set }
}
