import UIKit

class SettingViewController: UITableViewController {
  // MARK: - Subviews
  let tableHeader = SettingHeaderView()
  
  // MARK: - Properties
  let viewModel = SettingViewModel()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierachy()
  }
  
  // MARK: - Setup
  private func setupViewHierachy() {
    setupNavigationItems()
    setupTableView()
  }
  
  private func setupNavigationItems() {
    title = "Setting"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBarButton))
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveBarButton)),
      UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutBarButton))
    ]
  }
  
  private func setupTableView() {
    tableView.backgroundColor = .init(white: 0.95, alpha: 1)
    tableView.tableFooterView = UIView()
    tableHeader.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300)
    tableView.tableHeaderView = tableHeader
    setupTableHeaderView()
  }
  
  private func setupTableHeaderView() {
    tableHeader.leftSelectPhotoButton.addTarget(self, action: #selector(handleSelectPhoto(button:)), for: .touchUpInside)
    tableHeader.upperRightSelectPhotoButton.addTarget(self, action: #selector(handleSelectPhoto(button:)), for: .touchUpInside)
    tableHeader.bottomRightSelectPhotoButton.addTarget(self, action: #selector(handleSelectPhoto(button:)), for: .touchUpInside)
  }
  
  // MARK: - Action
  @objc private func handleCancelBarButton() {
    dismiss(animated: true)
  }
  
  @objc private func handleSaveBarButton() {
    dismiss(animated: true)
  }
  
  @objc private func handleLogoutBarButton() {
    dismiss(animated: true)
  }
  
  @objc private func handleSelectPhoto(button: UIButton) {
    let imagePicker = CustomImagePickerController()
    imagePicker.delegate = self
    imagePicker.modalPresentationStyle = .fullScreen
    present(imagePicker, animated: true, completion: {
      imagePicker.sender = button
    })
  }
}

// MARK: - UITableViewDelegate
extension SettingViewController {
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.titleForHeaderInSection(section)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let selectedImage = info[.originalImage] as? UIImage
    guard let picker = picker as? CustomImagePickerController,
          let button = picker.sender as? UIButton else {
            return
    }
    button.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    dismiss(animated: true)
  }
  

  
}
