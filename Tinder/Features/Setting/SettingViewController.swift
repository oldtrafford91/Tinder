import UIKit

class SettingViewController: UITableViewController {
  
  // MARK: - Subviews
  let leftSelectPhotoButton = UIButton.makeSelectPhotoButton(target: self, action: #selector(handleSelectPhoto))
  let upperRightSelectPhotoButton = UIButton.makeSelectPhotoButton(target: self, action: #selector(handleSelectPhoto))
  let bottomRightSelectPhotoButton = UIButton.makeSelectPhotoButton(target: self, action: #selector(handleSelectPhoto))
  // MARK: - Properties
  
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
    tableView.delegate = self
    tableView.dataSource = self
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
  
  // MARK: - Helpers
}

extension SettingViewController {
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView()
    header.backgroundColor = .blue
    header.addSubview(leftSelectPhotoButton)
    
    let padding: CGFloat = 16
    leftSelectPhotoButton.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
    
    let rightStackView = UIStackView(arrangedSubviews: [upperRightSelectPhotoButton, bottomRightSelectPhotoButton])
    rightStackView.axis = .vertical
    rightStackView.distribution = .fillEqually
    rightStackView.spacing = padding
    
    header.addSubview(rightStackView)
    rightStackView.anchor(top: header.topAnchor, leading: leftSelectPhotoButton.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    rightStackView.widthAnchor.constraint(equalTo: leftSelectPhotoButton.widthAnchor, multiplier: 1).isActive = true
    
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 300
  }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let selectedImage = info[.originalImage] as? UIImage
    guard let picker = picker as? CustomImagePickerController else { return }
    (picker.sender as! UIButton).setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    dismiss(animated: true)
  }
}
