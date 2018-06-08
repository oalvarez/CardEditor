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

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var cardView: CardView!
  let bag = DisposeBag()
  
  var viewModel = CardEditorViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cardViewModel = CardViewModel(card: CardModel(), cardInfo: CoverInfoModel())
    
    cardView.configureCard(with: cardViewModel)
    configureObservables()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func configureObservables() {
    
    textField.rx
    .text
    .orEmpty
    .bind(to: viewModel.introducedSring)
    .disposed(by: bag)
    
    viewModel.introducedStringObservable
      .subscribe(onNext: {
        self.cardView.title.text = $0
    })
    .disposed(by: bag)
  }


}

