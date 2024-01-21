import SwiftUI

struct TeamsViewCell: View {
    
    private let team: Team
    
    init(team: Team) {
        self.team = team
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: nil) {
            Text(team.fullName)
                .frame(maxWidth: 180, alignment: .leading)
            Spacer()
            
            Text(team.city)
                .frame(maxWidth: 80, alignment: .leading)
            Spacer()
            
            Text(team.conference.description)
                .frame(maxWidth: 50, alignment: .leading)
        }
    }
    
}

struct TeamsViewCell_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamsViewCell(team: Team(
            id: 1,
            city: "City",
            conference: .east,
            fullName: "fullName"
        ))
    }
}
