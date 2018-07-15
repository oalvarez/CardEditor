//
//  CardInfoModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

struct CardInfoModel: CardInfo {
  
  var infoTexts: [String]
  var imageNames: [String]
  
  public init(with cover: String = "cover.jpg", icon: String = "icon.png", title: String = "AdventCalendar", subtitle: String = "American Greetings", overDescription: String = "Cocos2D - Objective-C", about: String = "Advent Calendar over London Landscape. Every day user is able to unlock a building in London and enjoy the movement of Christmas", year: String = "2012") {
    
    infoTexts = [
      title,
      year,
      subtitle,
      overDescription,
      about,
      cover
    ]
    
    imageNames = [
      cover,
      icon
    ]
    
  }
  
  public init(with infoTexts: [String], andImageNames imageNames:[String]) {
    self.infoTexts = infoTexts
    self.imageNames = imageNames
  }
  
}
