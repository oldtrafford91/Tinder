import UIKit

class CardViewViewModel {
  typealias Observer<T> = (T) -> ()
  
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
  
  var currentImageIndex: Int = 0 {
    didSet {
      let image = images[currentImageIndex]
      onImageIndexChange((currentImageIndex, image))
    }
  }
  
  var onImageIndexChange: Observer<(Int, UIImage)> = { _ in }
  
  // MARK: - Initializer
  init(model: CardModelType) {
    self.model = model
  }
  
  // MARK: - Action
  
  func nextPhoto() {
    currentImageIndex = min(currentImageIndex + 1, images.count - 1)
  }
  
  func previousPhoto() {
    currentImageIndex = max(0, currentImageIndex - 1)
  }

}
