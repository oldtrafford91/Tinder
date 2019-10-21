import UIKit

class ViewController: UIViewController {
  
  // MARK: - Subviews
  let topStackView = TopNavigationStackView()
  let deckView = UIView()
  let bottomStackView = HomeBottomControlsStackView()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
  }
  
  // MARK: Setup
  private func configureViewHierachy() {
    view.backgroundColor = .systemBackground
    configureContainerStackView()
    configureDeckView()
  }
  
  private func configureContainerStackView() {
    let containerStackView = UIStackView(arrangedSubviews: [topStackView, deckView,bottomStackView])
    containerStackView.axis = .vertical
    view.addSubview(containerStackView)
    containerStackView.fillSuperviewSafeAreaLayoutGuide()
    containerStackView.isLayoutMarginsRelativeArrangement = true
    containerStackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    containerStackView.bringSubviewToFront(deckView)
  }
  
  private func configureDeckView() {
    let cardView = CardView()
    deckView.addSubview(cardView)
    cardView.fillSuperview()
  }
}
