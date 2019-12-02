import UIKit

class SettingHeaderView: UIView {
  
  // MARK: - Subviews
  let leftSelectPhotoButton = UIButton.makeSelectPhotoButton()
  let upperRightSelectPhotoButton = UIButton.makeSelectPhotoButton()
  let bottomRightSelectPhotoButton = UIButton.makeSelectPhotoButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func setup() {
    addSubview(leftSelectPhotoButton)
    let padding: CGFloat = 16
    leftSelectPhotoButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
    
    let rightStackView = UIStackView(arrangedSubviews: [upperRightSelectPhotoButton, bottomRightSelectPhotoButton])
    rightStackView.axis = .vertical
    rightStackView.distribution = .fillEqually
    rightStackView.spacing = padding
    addSubview(rightStackView)
    rightStackView.anchor(top: topAnchor, leading: leftSelectPhotoButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    rightStackView.widthAnchor.constraint(equalTo: leftSelectPhotoButton.widthAnchor, multiplier: 1).isActive = true
  }
  

}
