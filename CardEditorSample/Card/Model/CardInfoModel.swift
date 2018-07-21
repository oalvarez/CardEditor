//
//  CardInfoModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

struct CardInfoModel: Codable {
  var title: String
  var year: String
  var subtitle: String
  var overDescription: String
  var about: String
  var cover: String
  var icon: String
}

extension CardInfoModel: CardInfo {
  var textViewsInfo: [String] {
    get { return [about] }
    set { about = newValue[0] }
  }
  
  var textFieldsInfo: [String] {
    get { return [title, year, subtitle, overDescription] }
    set {
      title = newValue[0]
      year = newValue[1]
      subtitle = newValue[2]
      overDescription = newValue[3]
    }
  }
  
  var imageNames: [String] {
    get {  return [cover, icon] }
    set {
      cover = newValue[0]
      icon = newValue[1]
    }
  }
  
  
}


// For Text2 Json tipo
//struct CardInfoModel: CardInfo, Codable {
//  var textViewsInfo: [String]
//  var textFieldsInfo: [String]
//  var imageNames: [String]
//}
