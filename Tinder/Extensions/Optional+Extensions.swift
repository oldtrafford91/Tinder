extension Optional where Wrapped: Collection {
  func isNilOrEmpty() -> Bool {
    return self?.isEmpty ?? true
  }
  func isNotEmpty() -> Bool {
    return !self.isNilOrEmpty()
  }
}
