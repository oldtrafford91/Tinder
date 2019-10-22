import UIKit

class CardViewViewModel {
  private let model: CardModelType
  
  init(model: CardModelType) {
    self.model = model
  }
  
  var image: UIImage? {
    return UIImage(named: model.imageName)
  }
  
  var information: NSAttributedString {
    let information = NSMutableAttributedString()
    let name = NSAttributedString(string: model.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    information.append(name)
    if let user = model as? User {
      information.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular) ]))
      information.append(NSAttributedString(string: "\n \(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular) ]))
    } else {
      
    }
    return information
  }
  
  var textAlignment: NSTextAlignment {
    if model is User {
      return .left
    } else {
      return .center
    }
  }

}
