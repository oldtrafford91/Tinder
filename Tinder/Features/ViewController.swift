import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
  }
  
  private func configureViewHierachy() {
    view.backgroundColor = .systemBackground
    
    let topButtons = [UIColor.red, .black, .gray, .yellow].map {
      UIButton(backgroundColor: $0)
    }
    let topStackView = UIStackView(arrangedSubviews: topButtons)
    topStackView.axis = .horizontal
    topStackView.alignment = .center
    topStackView.distribution = .equalSpacing
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    let middleView = UIView()
    middleView.backgroundColor = .red
    
    let bottomButtons = [UIColor.red, .black, .gray, .yellow].map {
      UIButton(backgroundColor: $0)
    }
    let bottomStackView = UIStackView(arrangedSubviews: bottomButtons)
    bottomStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    bottomStackView.axis = .horizontal
    bottomStackView.alignment = .center
    bottomStackView.distribution = .fillEqually

    
    let containerStackView = UIStackView(arrangedSubviews: [topStackView, middleView,bottomStackView])
    containerStackView.axis = .vertical
    view.addSubview(containerStackView)
    containerStackView.fillSuperviewSafeAreaLayoutGuide()
  }
  

  
  
}
