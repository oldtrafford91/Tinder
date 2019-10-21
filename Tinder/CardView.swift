import UIKit

class CardView: UIView {
  
  // MARK: - Subviews
  let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
  
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
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    addGestureRecognizer(panGesture)
  }
  
  // MARK: - Action
  @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .changed:
      handleChanged(gesture)
    case .ended:
      handleEndedGesture()
    default:
      ()
    }
  }
  
  private func handleChanged(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: self)
    transform = CGAffineTransform(translationX: translation.x, y: translation.y)
  }
  
  private func handleEndedGesture() {
    UIView
      .animate(withDuration: 0.75,
                   delay: 0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.1,
                   options: .curveEaseOut,
                   animations: {
                    self.transform = .identity
      }, completion: { _ in

      })
  }
  
  // MARK: - Helpers
  
  
}
