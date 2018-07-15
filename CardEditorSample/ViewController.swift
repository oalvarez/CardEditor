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
  @IBOutlet weak var nextButton: UIButton!
  
  let bag = DisposeBag()
  
  var viewModel = CardEditorViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cardViewModel = CardViewModel(with: CardModel(), cardInfo: CardInfoModel())
    
    cardView.configureCard(with: cardViewModel)
    cardView.configureCardForEdition()
    //TODO: Move this logic to the view Model
//    cardView.viewModel.selectedImageIndex = 0
    cardView.configureFontStyle()
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
    
    nextButton.rx
    .tap
    .asDriver()
    .drive(onNext: { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.cardView.viewModel.incrementSelectedImageIndex()
    })
    .disposed(by: bag)
    
    viewModel.introducedStringObservable
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.cardView.viewModel.updateSelectedImageName(with: $0)
        print("Update image with url: \($0)")
    })
    .disposed(by: bag)
    
    viewModel.introducedRadiusObservable
      .subscribe(onNext: {[weak self] in
        guard let strongSelf = self else { return }
        strongSelf.cardView.viewModel.upateCornerRadius(with: $0)
      })
      .disposed(by: bag)
    
    viewModel.shadowIsOnObservable
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.cardView.viewModel.upateShadow(with: $0)
      })
    .disposed(by: bag)
    
    
    cardView.coverImage.applyShinny()

  }
}

extension UIView {
  func applyShinny() {
    
    let shiny = UIView()
    shiny.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
    shiny.frame = bounds
    addSubview(shiny)
    shiny.pinToSuperview()
    print(shiny.constraints.count)
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.clear.cgColor,  UIColor.white.cgColor, UIColor.clear.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.40)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.60)
    gradientLayer.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)

    shiny.layer.mask = gradientLayer

    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    animation.fromValue = -shiny.frame.width
    animation.toValue = shiny.frame.width
    animation.repeatCount = .infinity
    animation.duration = 1
    gradientLayer.add(animation, forKey: "shimmerAnimation")
  }
}
