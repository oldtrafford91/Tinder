import UIKit

extension UIButton {
  static func makeImageButton(image: UIImage, target: Any? = nil, action: Selector? = nil) -> UIButton {
    return UIButton.systemButton(with: image.withRenderingMode(.alwaysOriginal),
                                 target: target,
                                 action: action)
  }
  
  static func makeSelectPhotoButton(target: Any? = nil, action: Selector? = nil) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 12
    button.clipsToBounds = true
    button.contentMode = .scaleAspectFill
    guard let action = action else { return button }
    button.addTarget(target, action: action , for: .touchUpInside)
    return button
  }
}
