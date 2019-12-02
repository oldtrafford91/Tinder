import Foundation

class SettingViewModel {
  // MARK: - Properties
  private let sectionNames = ["Names", "Profession", "Age", "Bio", "Seeking Age Range"]
  private var user: User?
  
  func titleForHeaderInSection(_ section: Int) -> String {
    return sectionNames[section]
  }
  
  func numberOfSections() -> Int {
    return sectionNames.count
  }
  
  func getUserInfo() {
    
  }
}

