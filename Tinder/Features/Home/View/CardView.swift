import UIKit

private enum CardViewDismissDirection: CGFloat {
  case right = 1
  case left = -1
}

class CardView: UIView {
  // MARK: Constant
  private let threshold: CGFloat = 100
  
  // MARK: - Subviews
  private let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
  private let informationLabel = UILabel()
  
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func configure() {
    layer.cornerRadius = 12
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    informationLabel.textColor = .white
    informationLabel.numberOfLines = 0
    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16))
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
  
  func bind(with viewModel: CardViewViewModel) {
    imageView.image = viewModel.image
    informationLabel.attributedText = viewModel.information
    informationLabel.textAlignment = viewModel.textAlignment
  }
  
  // MARK: - Action
  @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .changed:
      handleChanged(gesture)
    case .ended:
      handleEndedGesture(gesture)
    default:
      ()
    }
  }
  
  private func handleChanged(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: self)
    let degree: CGFloat = translation.x / 20
    let angle: CGFloat = degree * .pi / 180
    let rotationTransform = CGAffineTransform(rotationAngle: angle)
    
    transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
  }
  
  private func handleEndedGesture(_ gesture: UIPanGestureRecognizer) {
    let translationDirection: CardViewDismissDirection = gesture.translation(in: self).x > 0 ? .right : .left
    let shouldDismissCard = abs(gesture.translation(in: self).x) > threshold

    UIView
      .animate(withDuration: 0.75,
                   delay: 0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.1,
                   options: .curveEaseOut,
                   animations: {
                    if shouldDismissCard {
                      self.transform = CGAffineTransform(translationX: 600 * translationDirection.rawValue , y: 0)
                    } else {
                      self.transform = .identity
                    }

      }, completion: { _ in
        self.transform = .identity
      })
  }
  
  // MARK: - Helpers
  
  
}
