//
//  CardInfoPresentable.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 15/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import RxSwift

protocol CardInfoPresentable {
  var cardInfo: Variable<CardInfo> { get set }
  var showFrames: Variable<Bool> { get }
  var selectedImageIndex: Int { get set }
  
  var cardInfoObservable: Observable<CardInfo> { get }
  var showFramesObservable: Observable<Bool> { get }
  func hideFrames()
  func toggleShowFrames()
  mutating func incrementSelectedImageIndex()
  func updateSelectedImageName(with text: String)
  func string(at index: Int) -> String
}

extension CardInfoPresentable {
  var cardInfoObservable: Observable<CardInfo> { return cardInfo.asObservable() }
  var showFramesObservable: Observable<Bool> { return showFrames.asObservable() }
  
  func updateSelectedImageName(with text: String) {
    guard 0..<cardInfo.value.imageNames.count ~= selectedImageIndex
      else { return }
    cardInfo.value.imageNames[selectedImageIndex] = text
  }
  
  func updateElement(at index: Int, with text: String) {
    cardInfo.value.textFieldsInfo[index] = text
  }
  
  mutating func incrementSelectedImageIndex() {
    selectedImageIndex += 1
  }
  
  func hideFrames() {
    showFrames.value = false
  }
  
  func toggleShowFrames() {
    showFrames.value.toggle()
  }
  
  func string(at index: Int) -> String {
    return cardInfo.value.textFieldsInfo[index]
  }
  
  func updateTextFields(with info: [String]) {
    cardInfo.value.textFieldsInfo = info
  }
  
  func updateTextViews(with info: [String]) {
    cardInfo.value.textViewsInfo = info
  }
  
  func printValues() {
    cardInfo.value.textFieldsInfo.forEach {
      print($0)
    }
  }
}
