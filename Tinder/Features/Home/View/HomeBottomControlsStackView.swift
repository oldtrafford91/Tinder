import UIKit

class HomeBottomControlsStackView: UIStackView {

  // MARK: - Subviews
  let refreshButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "refresh_circle"))
  let dislikeButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "dismiss_circle"))
  let superLikeButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "super_like_circle"))
  let likeButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "like_circle"))
  let specialButton: UIButton = makeImageButton(image: #imageLiteral(resourceName: "boost_circle"))
  
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setup() {
    [refreshButton, dislikeButton, superLikeButton, likeButton, specialButton].forEach {
      addArrangedSubview($0)
    }
    heightAnchor.constraint(equalToConstant: 100).isActive = true
    axis = .horizontal
    alignment = .center
    distribution = .fillEqually
  }
  
  private static func makeImageButton(image: UIImage) -> UIButton {
    return UIButton.systemButton(with: image.withRenderingMode(.alwaysOriginal),
    target: nil,
    action: nil)
  }
}
