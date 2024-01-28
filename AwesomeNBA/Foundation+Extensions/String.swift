import Foundation

extension String {

    /// Returns the localized `self`.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with text: String) -> String {
        return NSLocalizedString(text, comment: "")
            .replacingOccurrences(of: "/@", with: self)
    }

}
