import UIKit
import Firebase
import JGProgressHUD

class HomeViewController: UIViewController {
  
  // MARK: - Subviews
  let topStackView = TopNavigationStackView()
  let deckView = UIView()
  let bottomStackView = HomeBottomControlsStackView()
  let loadingHUD = JGProgressHUD()
  
  // MARK: Properties
  let viewModel = HomeViewModel()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierachy()
    fetchUsers()
  }
  
  // MARK: Setup
  private func setupViewHierachy() {
    view.backgroundColor = .systemBackground
    setupContainerStackView()
    setupTopStackView()
    setupBottomStackView()
    setupViewModelBinding()
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
    for cardViewModel in viewModel.cardViewModels {
      let cardView = CardView(viewModel: cardViewModel)
      deckView.addSubview(cardView)
      deckView.sendSubviewToBack(cardView)
      cardView.fillSuperview()
    }
  }
  
  private func setupBottomStackView() {
    bottomStackView.refreshButton.addTarget(self, action: #selector(handleRefreshButton(sender:)), for: .touchUpInside)
  }
  
  private func setupViewModelBinding() {
    viewModel.onFetchingUser = { [weak self] isLoading in
      guard let self = self else { return }
      if isLoading {
        self.loadingHUD.show(in: self.view)
      } else {
        self.loadingHUD.dismiss()
      }
    }
    
    viewModel.onFetchUserFailed = { [weak self] error in
      guard let self = self else { return }
      self.showHUDWithError(title: "Fetch User Failed", error: error, in: self.view)
    }
    
    viewModel.onFetchedUser = { [weak self] _ in
      guard let self = self else { return }
      self.setupDeckView()
    }
  }
  
  // MARK: Action
  
  @objc private func handleSettingButton(sender button: UIButton ) {
    let registrationVC = RegistrationViewController()
    registrationVC.modalPresentationStyle = .fullScreen
    present(registrationVC, animated: true, completion: nil)
  }
  
  @objc private func handleRefreshButton(sender button: UIButton ) {
    fetchUsers()
  }
  
  private func fetchUsers() {
    viewModel.fetchUsers()
  }
}
