import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Subviews
  let topStackView = TopNavigationStackView()
  let deckView = UIView()
  let bottomStackView = HomeBottomControlsStackView()
  
  // MARK: Properties
  let deckModel: [CardModelType] = [
    User(name: "Kelly", age: 18, profession: "DJ", userImages: ["kelly1", "kelly2", "kelly3"]),
    User(name: "Ngoc Trinh", age: 28, profession: "Model", userImages: ["ngoctrinh1", "ngoctrinh2", "ngoctrinh3"]),
    Adveriser(title: "We build Windows and Azure", brandName: "Microsoft", brandImages: ["slide_out_menu_poster"])
  ]
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierachy()
  }
  
  // MARK: Setup
  private func setupViewHierachy() {
    view.backgroundColor = .systemBackground
    setupContainerStackView()
    setupTopStackView()
    setupDeckView()
  }
  
  private func setupContainerStackView() {
    let containerStackView = UIStackView(arrangedSubviews: [topStackView, deckView,bottomStackView])
    containerStackView.axis = .vertical
    view.addSubview(containerStackView)
    containerStackView.fillSuperviewSafeAreaLayoutGuide()
    containerStackView.isLayoutMarginsRelativeArrangement = true
    containerStackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    containerStackView.bringSubviewToFront(deckView)
  }
  
  private func setupTopStackView() {
    topStackView.settingButton.addTarget(self, action: #selector(handleSettingButton(sender:)), for: .touchUpInside)
  }
  
  private func setupDeckView() {
    for model in deckModel {
      let cardView = CardView(viewModel: CardViewViewModel(model: model))
      deckView.addSubview(cardView)
      cardView.fillSuperview()
    }
  }
  
  // MARK: Action
  
  @objc private func handleSettingButton(sender button: UIButton ) {
    let registrationVC = RegistrationViewController()
    registrationVC.modalPresentationStyle = .fullScreen
    present(registrationVC, animated: true, completion: nil)
  }
}
