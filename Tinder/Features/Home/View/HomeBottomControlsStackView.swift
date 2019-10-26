import UIKit

class HomeBottomControlsStackView: UIStackView {
  
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
    let subViews = [ #imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map {
      UIButton.systemButton(with: $0.withRenderingMode(.alwaysOriginal),
                            target: nil,
                            action: nil)
    }
    subViews.forEach {
      addArrangedSubview($0)
    }
    heightAnchor.constraint(equalToConstant: 100).isActive = true
    axis = .horizontal
    alignment = .center
    distribution = .fillEqually
  }
}
