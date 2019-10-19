import UIKit

class ViewController: UIViewController {
  
  // MARK: - Subviews
  let topStackView = TopNavigationStackView()
  let middleView = UIView()
  let bottomStackView = HomeBottomControlsStackView()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
  }
  
  // MARK: Setup
  private func configureViewHierachy() {
    view.backgroundColor = .systemBackground
    middleView.backgroundColor = .red
    
    let containerStackView = UIStackView(arrangedSubviews: [topStackView, middleView,bottomStackView])
    containerStackView.axis = .vertical
    view.addSubview(containerStackView)
    containerStackView.fillSuperviewSafeAreaLayoutGuide()
  }
}
