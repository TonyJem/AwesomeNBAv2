import Foundation

extension String {
    
    static func systemImage(_ symbolName: CustomSymbol) -> String {
        return symbolName.rawString()
    }
    
}

enum CustomSymbol: String, CaseIterable {
    
    func rawString() -> String {
        return self.rawValue
    }
    
    case home = "house.circle"
    case players = "person.2.circle"
}
