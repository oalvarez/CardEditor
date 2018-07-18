//
//  CardView.swift
//  CardEditorSample
//
//  Created by Oscar Alvarez on 08/06/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit
import RxSwift

class CardView: UIView {
  let bag = DisposeBag()
  var viewModel: CardWithInfoPresentable!
  
  @IBOutlet weak var coverImage: UIImageView!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var backView: UIView!
  
  @IBOutlet weak var title: UITextField!
  @IBOutlet weak var year: UITextField!
  @IBOutlet weak var subtitle: UITextField!
  @IBOutlet weak var overAbout: UITextField!
  @IBOutlet weak var about: UITextView! {
    didSet {
      about.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      about.textContainer.lineFragmentPadding = 0
    }
  }
  
  @IBOutlet var view: UIView!
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadNibFile()
  }

}

extension CardView {
  func addTapGestureForEdition() {
    let cardTap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
    self.addGestureRecognizer(cardTap)
  }

  @objc func tapCard(_ sender: UITapGestureRecognizer) {
    viewModel.toggleShowFrames()
  }
}

extension CardView {
  func configureFontStyle() {
    title.font = .titleFont
    year.font = .yearFont
    subtitle.font = .subtitleFont
    overAbout.font = .overAboutFont
    about.font = .aboutFont
  }
}

extension CardView: CardViewProtocol {
  var imageViews: [UIImageView] {
    return [
      coverImage,
      iconImage
    ]
  }
  var fullCardViews: [UIView] {
    return [
      coverImage,
      backView
    ]
  }
  var textFields: [UITextField] {
    return [
      title,
      year,
      subtitle,
      overAbout
    ]
  }
}

extension CardView: NibLoaderViewProtocol { }
