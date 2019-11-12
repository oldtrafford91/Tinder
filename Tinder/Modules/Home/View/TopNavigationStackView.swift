import UIKit

class TopNavigationStackView: UIStackView {
  
  // MARK: - Subviews
  let settingButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: #imageLiteral(resourceName: "fire"))
  
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func configure() {
    settingButton.setBackgroundImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
    messageButton.setBackgroundImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
    fireImageView.contentMode = .scaleAspectFit
    [settingButton, fireImageView, messageButton].forEach {
      addArrangedSubview($0)
    }
    
    axis = .horizontal
    alignment = .center
    distribution = .equalCentering
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}
