//
//  CardEditorViewModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

struct CardEditorViewModel {
  /*
   necesio guardar un texto
  */
  var introducedSring = Variable<String>("")
  var introducedStringObservable: Observable<String> {
    return introducedSring.asObservable()
  }
}
