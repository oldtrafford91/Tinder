import Foundation
import PromiseKit

class HomeViewModel {
  typealias Observer<T> = (T) -> ()
  
  private var users: [User] = [] {
    didSet {
      cardViewModels = makeCardViewModels(from: users)
    }
  }
  var cardViewModels: [CardViewViewModel] = []
  private var isLoading = false { didSet { onLoadingStateChange(isLoading) } }
  
  var onLoadingStateChange: Observer<Bool> = { _ in }
  var onFetchedUser: Observer<[User]> = { _ in }
  var onFetchUserFailed: Observer<Error> = { _ in}
  
  // MARK: - Action
  
  func fetchUsers() {
    isLoading = true
    firstly {
      FirebaseUserService.fetchUsers()
    }.done { users in
      self.users = users
      self.onFetchedUser(users)
    }.ensure {
      self.isLoading = false
    }.catch { error in
      self.onFetchUserFailed(error)
    }
  }
  
  // MARK: - Helpers
  private func makeCardViewModels(from users: [User]) -> [CardViewViewModel] {
    return users.map { CardViewViewModel(model: $0) }
  }
  
}
