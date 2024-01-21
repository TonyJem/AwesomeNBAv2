import SwiftUI

struct ColumnHeaderText: View {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.bold)
    }
    
}
