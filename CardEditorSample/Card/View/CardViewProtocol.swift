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
  var viewModel: CardViewModelProtocol! { get set }
  
  var textFields: [UITextField] { get }
  var imageViews : [UIImageView] { get }
  var fullCardViews : [UIView] { get }
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
  
  //Second extension of ViewCard
  
  func configureCard(with viewModel: CardViewModelProtocol) {
    self.viewModel = viewModel
    configureObservables()
  }
  
  func configureCardForEdition() {
    //addTapGestureForEdition()
  }
  
  func configureObservables() {
    viewModel.cardInfoObservable
      .subscribe(onNext: { [weak self] cardInfo in
        guard let strongSelf = self else { return }
        for (label, text) in zip(strongSelf.textFields, cardInfo.infoTexts) {
          label.text = text
        }
        for (imageView, name) in zip(strongSelf.imageViews, cardInfo.imageNames) {
          imageView.image = UIImage(named: name)
        }
      })
      .disposed(by: bag)
    
    viewModel.cardObservable
      .subscribe(onNext: { [weak self] card in
        guard let strongSelf = self else { return }
        strongSelf.fullCardViews.forEach {
          $0.cornerRadius = card.radius
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
  }
}

