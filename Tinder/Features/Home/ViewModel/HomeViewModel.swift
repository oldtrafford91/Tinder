import Foundation
import PromiseKit

class HomeViewModel {
  typealias Observer<T> = (T) -> ()
  
  // MARK: - Properties
  private var users: [User] = [] {
    didSet {
      cardViewModels = makeCardViewModels(from: users)
    }
  }
  var cardViewModels: [CardViewViewModel] = []
  var lastFetchedUser: User?
  
  var onFetchingUser: Observer<Bool> = { _ in }
  var onFetchedUser: Observer<[User]> = { _ in }
  var onFetchUserFailed: Observer<Error> = { _ in}
  
  // MARK: - Action
  
  func fetchUsers() {
    onFetchingUser(true)
    firstly {
      FirebaseUserService.fetchUsers(lastFetchedUser: lastFetchedUser)
    }.done { users in
      self.users = users
      self.lastFetchedUser = users.last
      self.onFetchedUser(users)
    }.ensure {
      self.onFetchingUser(false)
    }.catch { error in
      self.onFetchUserFailed(error)
    }
  }
  
  // MARK: - Helpers
  private func makeCardViewModels(from users: [User]) -> [CardViewViewModel] {
    return users.map { CardViewViewModel(model: $0) }
  }
  
}
