import Foundation

extension String {

    /// Returns the localized `self`.
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }

}
