import Foundation

extension String {

    /// Returns the localized `self`.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func formatted(text: String) -> String {
        let tempStr = String(format: self, text)
        return tempStr
    }

}
