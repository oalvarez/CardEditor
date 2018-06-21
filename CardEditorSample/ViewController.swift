//
//  ViewController.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var shadowSwitch: UISwitch!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var cardView: CardView!
  let bag = DisposeBag()
  
  var viewModel = CardEditorViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cardViewModel = CardViewModel(with: CardModel(), cardInfo: CoverInfoModel())
    
    cardView.configureCard(with: cardViewModel)
    cardView.configureCardForEdition()
    textField.text = cardView.viewModel.title
    configureObservables()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func configureObservables() {
    
    textField.rx
    .text
    .orEmpty
    .bind(to: viewModel.introducedSring)
    .disposed(by: bag)
    
    slider.rx
    .value
    .map { CGFloat($0)}
    .bind(to: viewModel.introducedRadius)
    .disposed(by: bag)
    
    shadowSwitch.rx
    .isOn
    .bind(to: viewModel.shadowIsOn)
    .disposed(by: bag)
    
    viewModel.introducedStringObservable
      .subscribe(onNext: {
        self.cardView.viewModel.updateActiveLabel(with: $0)
    })
    .disposed(by: bag)
    
    cardView.viewModel.selectedElementTagObservable
      .subscribe(onNext: {
        self.textField.text = self.cardView.viewModel.string(from: $0)
      })
      .disposed(by: bag)
    
    viewModel.introducedRadiusObservable
      .subscribe(onNext: {
        self.cardView.viewModel.upateCornerRadius(with: $0)
      })
      .disposed(by: bag)
    
    viewModel.shadowIsOnObservable
      .subscribe(onNext: {
        self.cardView.viewModel.upateShadow(with: $0)
      })
    .disposed(by: bag)
    
  }
}

