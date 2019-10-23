import UIKit

struct CardViewViewModel {
  
  // MARK: Properties
  private let model: CardModelType
  
  var image: UIImage? {
    if let user = model as? User {
      return UIImage(named: user.userImage)
    } else if let advertiser = model as? Adveriser {
      return UIImage(named: advertiser.brandImage)
    }
    return nil
  }
  
  var information: NSAttributedString {
    let information = NSMutableAttributedString()
    
    if let user = model as? User {
      let name = NSAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
      information.append(name)
      information.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular) ]))
      information.append(NSAttributedString(string: "\n \(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular) ]))
    } else if let brand = model as? Adveriser{
      let brandName = NSAttributedString(string: brand.brandName, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
      information.append(brandName)
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
  
  // MARK: Initializer
  init(model: CardModelType) {
    self.model = model
  }

}
