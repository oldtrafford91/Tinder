import UIKit
import Kingfisher

class CardViewViewModel {
  typealias Observer<T> = (T) -> ()
  
  // MARK: Properties
  private let item: CardItem
  
  var imageURLs: [URL] {
    if let user = item as? User {
      return user.userImages.compactMap {
        URL(string: $0)
      }
    } else if let advertiser = item as? Adveriser {
      return advertiser.brandImages.compactMap {
        URL(string: $0)
      }
    }
    return []
  }
  
  var information: NSAttributedString {
    let information = NSMutableAttributedString()
    if let user = item as? User {
      information.append(NSAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)]))
      
      let ageString = (user.age != nil) ? "\(user.age!)" : "N\\A"
      
      information.append(NSAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular) ]))
      information.append(NSAttributedString(string: "\n \(user.profession ?? "Not available")", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular) ]))
    } else if let advertiser = item as? Adveriser{
      information.append(NSAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)]))
      information.append(NSAttributedString(string: "\n \(advertiser.brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
    }
    return information
  }
  
  var textAlignment: NSTextAlignment {
    if item is User {
      return .left
    } else {
      return .center
    }
  }
  
  var currentImageIndex: Int = 0 {
    didSet {
      let imageURL = imageURLs[currentImageIndex]
      onImageIndexChange((currentImageIndex, imageURL))
    }
  }
  
  var onImageIndexChange: Observer<(Int, URL)> = { _ in }
  
  // MARK: - Initializer
  init(model: CardItem) {
    self.item = model
  }
  
  // MARK: - Action
  
  func nextPhoto() {
    currentImageIndex = min(currentImageIndex + 1, imageURLs.count - 1)
  }
  
  func previousPhoto() {
    currentImageIndex = max(0, currentImageIndex - 1)
  }

}

// MARK: Factory
extension CardViewViewModel {
  static func makeCardViewModels(from users: [User]) -> [CardViewViewModel] {
    return users.map { CardViewViewModel(model: $0) }
  }
}
