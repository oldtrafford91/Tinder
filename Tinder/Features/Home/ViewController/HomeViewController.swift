import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Subviews
  let topStackView = TopNavigationStackView()
  let deckView = UIView()
  let bottomStackView = HomeBottomControlsStackView()
  
  // MARK: Properties
  let deckModel: [CardModelType] = [
    User(name: "Kelly", age: 18, profession: "DJ", userImages: ["kelly1", "kelly2", "kelly3"]),
    User(name: "Jane", age: 18, profession: "Teacher", userImages: ["jane1", "jane2", "jane3"]),
    Adveriser(title: "We build Windows and Azure", brandName: "Microsoft", brandImages: ["slide_out_menu_poster"])
  ]
  
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
    for model in deckModel {
      let cardView = CardView()
      cardView.bind(with: CardViewViewModel(model: model))
      deckView.addSubview(cardView)
      cardView.fillSuperview()
    }
  }
}
