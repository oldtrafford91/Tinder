import UIKit

extension UIView {
  func removeAllAnimation() {
    superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
  }
}
