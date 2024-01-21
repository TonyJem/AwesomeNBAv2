import SwiftUI

struct PlayersViewCell: View {
    
    private let player: Player
    
    init(player: Player) {
        self.player = player
    }

    var body: some View {
        HStack(alignment: .center, spacing: nil) {
            Text(player.firstName)
                .frame(maxWidth: 80, alignment: .leading)
            Spacer()
            Text(player.lastName)
                .frame(maxWidth: 120, alignment: .leading)
            Spacer()
            Text(player.team.fullName)
                .frame(maxWidth: 120, alignment: .leading)
        }
    }
    
}

struct PlayersViewCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayersViewCell(player: Player(
            id: 11,
            firstName: "FirstNamis",
            lastName: "LastNames",
            team: Team(
                id: 1,
                city: "City",
                conference: .east,
                fullName: "FullName"
            )
        ))
    }
}
