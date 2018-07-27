//
//  CardViewProtocol.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 13/07/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import Foundation
import RxSwift

protocol CardViewProtocol: class {
  var bag: DisposeBag { get }
  var viewModel: CardWithInfoPresentable! { get set }
  var contentView: UIView! { get }
  
  var textFields: [UITextField] { get }
  var textViews: [UITextView] { get }
  var imageViews : [UIImageView] { get }
}

extension CardViewProtocol where Self: UIView {
  var selectedTextField: UITextField? {
    return textFields.first(where: { $0.isFirstResponder } )
  }
  
  func showEmptyFields(_ show:Bool) {
    textFields.forEach {
      $0.isHidden = $0.text!.isEmpty ? !show : false
    }
  }
  
  func showPopulatedFields(_ show:Bool) {
    textFields.forEach {
      $0.isHidden = $0.text!.isEmpty ? true : !show
    }
  }
  
  func prepareFieldsForEdition(_ edition: Bool) {
    textFields.forEach {
      $0.isUserInteractionEnabled = edition
    }
  }
  
  func configureCard(with viewModel: CardWithInfoPresentable) {
    self.viewModel = viewModel
    configureObservables()
  }
  
  func configureCardForEdition() {
    //addTapGestureForEdition()
  }
  
  func configureObservables() {
    contentView.frame = bounds
    viewModel.cardInfoObservable
//      .distinctUntilChanged {
//        print("🍉", $0.textFieldsInfo == $1.textFieldsInfo)
//        return $0.textFieldsInfo == $1.textFieldsInfo
//      }
      .subscribe(onNext: { [weak self] cardInfo in
        guard let strongSelf = self else { return }
        for (textField, text) in zip(strongSelf.textFields, cardInfo.textFieldsInfo) {
          textField.text = text
        }
        for (textView, text) in zip(strongSelf.textViews, cardInfo.textViewsInfo) {
          textView.text = text
        }
        for (imageView, name) in zip(strongSelf.imageViews, cardInfo.imageNames) {
          imageView.image = UIImage(named: name)
        }
      })
      .disposed(by: bag)
    
    viewModel.cardObservable
      .subscribe(onNext: { [weak self] card in
        guard let strongSelf = self else { return }
        if let corners = card.roundedCorners {
          let cornerRadius: UIRectCorner = [corners.bottomLeft  ? .bottomLeft : [],
                                            corners.bottomRight ? .bottomRight : [],
                                            corners.topLeft     ? .topLeft : [],
                                            corners.topRight    ? .topRight : []]
          strongSelf.contentView.setCornerRadius(with: cornerRadius, and: card.radius)
        }
        else {
          strongSelf.contentView.cornerRadius = card.radius
        }
        strongSelf.withShadow = card.shadow
      })
      .disposed(by: bag)
    
    viewModel.showFramesObservable
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.showEmptyFields($0)
      })
      .disposed(by: bag)
    
    textFields.forEach {
      $0.rx
        .controlEvent(.editingChanged)
        .asObservable()
        .subscribe(onNext: {
          var texts = self.textFields.map { $0.text ?? "" }
          self.viewModel.updateTextFields(with: texts)
          
          texts = self.textViews.map { $0.text ?? "" }
          self.viewModel.updateTextViews(with: texts)
        })
        .disposed(by: bag)
    }
  }

}

