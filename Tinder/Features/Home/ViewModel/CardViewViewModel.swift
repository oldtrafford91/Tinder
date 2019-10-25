import UIKit

struct CardViewViewModel {
  
  // MARK: Properties
  private let model: CardModelType
  
  var images: [UIImage] {
    if let user = model as? User {
      return user.userImages.compactMap {
        UIImage(named: $0)
      }
    } else if let advertiser = model as? Adveriser {
      return advertiser.brandImages.compactMap {
        UIImage(named: $0)
      }
    }
    return []
  }
  
  var information: NSAttributedString {
    let information = NSMutableAttributedString()
    if let user = model as? User {
      information.append(NSAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)]))
      information.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular) ]))
      information.append(NSAttributedString(string: "\n \(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular) ]))
    } else if let advertiser = model as? Adveriser{
      information.append(NSAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)]))
      information.append(NSAttributedString(string: "\n \(advertiser.brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
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
  
  // MARK: - Initializer
  init(model: CardModelType) {
    self.model = model
  }
  
  // MARK: - Helpers

}
