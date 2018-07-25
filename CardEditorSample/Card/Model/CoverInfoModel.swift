//
//  CoverInfoModel.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

struct CoverInfoModel: CoverInfoPresenter {
  var title: String?
  var subtitle: String?
  var overDescription: String?
  var about: String?
  var year: String?
  //Will be urls
  var coverImageName: String?
  var iconImageName: String?
  
  public init(with cover: String? = "cover.jpg", icon: String? = "icon.png", title: String = "AdventCalendar", subtitle: String? = "American Greetings", overDescription: String? = "Cocos2D - Objective-C", about: String? = "Advent Calendar over London Landscape. Every day user is able to unlock a building in London and enjoy the movement of Christmas", year: String? = "2012") {
    self.coverImageName = cover
    self.iconImageName = icon
    self.title = title
    self.subtitle = subtitle
    self.overDescription = overDescription
    self.about = about
    self.year = year
  }
}
