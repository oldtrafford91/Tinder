import UIKit
import JGProgressHUD

extension UIViewController {
  func showHUDWithError(title: String, error: Error, delay: Double = 4, in view: UIView) {
    let hud = JGProgressHUD()
    hud.textLabel.text = title
    hud.detailTextLabel.text = error.localizedDescription
    hud.show(in: view)
    hud.dismiss(afterDelay: delay)
  }
}

