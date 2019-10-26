import UIKit

private enum CardViewDismissDirection: CGFloat {
  case right = 1
  case left = -1
}

class CardView: UIView {
  // MARK: Constant
  private let threshold: CGFloat = 100
  private let barSelectedColor: UIColor = .white
  private let barDeselectedColor: UIColor = .init(white: 0, alpha: 0.1)
  
  // MARK: - Subviews
  private let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
  private let informationLabel = UILabel()
  private let gradientLayer = CAGradientLayer()
  private let barStackView = UIStackView()
  
  // MARK: - Properties
  private var viewModel: CardViewViewModel!
  private var currentImageIndex: Int = 0
  
  // MARK: - Initializer
  private override init(frame: CGRect) {
    super.init(frame: frame)
    commonSetup()
  }
  
  init(viewModel: CardViewViewModel) {
    super.init(frame: .zero)
    self.viewModel = viewModel
    commonSetup()
    setup(with: viewModel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  override func layoutSubviews() {
    gradientLayer.frame = self.frame
  }
  
  // MARK: - Setup
  private func commonSetup() {
    layer.cornerRadius = 12
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
    
    setupImageView()
    setupBarStackView()
    setupGradientLayer()
    setupInformationLabel()
    setupPangesture()
    setupTapGesture()
  }
  
  private func setupImageView() {
    addSubview(imageView)
    imageView.fillSuperview()
  }
  
  private func setupInformationLabel() {
    informationLabel.textColor = .white
    informationLabel.numberOfLines = 0
    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16))
  }

  
  private func setupGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.5, 1.1]
    layer.addSublayer(gradientLayer)
  }
  
  private func setupBarStackView() {
    barStackView.axis = .horizontal
    barStackView.distribution = .fillEqually
    barStackView.spacing = 5
    addSubview(barStackView)
    barStackView.translatesAutoresizingMaskIntoConstraints = false
    barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
  }
  
  private func setupPangesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
  
  private func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    addGestureRecognizer(tapGesture)
  }
  
  func setup(with viewModel: CardViewViewModel) {
    self.viewModel = viewModel
    
    imageView.image = viewModel.images[currentImageIndex]
    informationLabel.attributedText = viewModel.information
    informationLabel.textAlignment = viewModel.textAlignment
    
    (0...viewModel.images.count-1).forEach { _ in
      let barView = UIView()
      barView.backgroundColor = barDeselectedColor
      barStackView.addArrangedSubview(barView)
    }
    barStackView.arrangedSubviews.first?.backgroundColor = barSelectedColor
  }
  
  // MARK: - Action
  @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      removeAllAnimation()
    case .changed:
      handlePanChanged(gesture)
    case .ended:
      handlePanEnded(gesture)
    default:
      ()
    }
  }
  
  private func handlePanChanged(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: self)
    let degree: CGFloat = translation.x / 20
    let angle: CGFloat = degree * .pi / 180
    let rotationTransform = CGAffineTransform(rotationAngle: angle)
    
    transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
  }
  
  private func handlePanEnded(_ gesture: UIPanGestureRecognizer) {
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
//        self.transform = .identity
      })
  }
  
  @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
    let location = gesture.location(in: self)
    print(location.x)
    let shouldAdvanceToNextPhoto = location.x > (frame.size.width / 2)
    if shouldAdvanceToNextPhoto {
      currentImageIndex = min(currentImageIndex + 1, viewModel.images.count - 1)
    } else {
      currentImageIndex = max(0, currentImageIndex - 1)
    }
    barStackView.arrangedSubviews.forEach { $0.backgroundColor = barDeselectedColor }
    barStackView.arrangedSubviews[currentImageIndex].backgroundColor = barSelectedColor
    imageView.image = viewModel?.images[currentImageIndex]
  }
}
