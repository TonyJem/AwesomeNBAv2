import SwiftUI

struct GamesViewCell: View {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: nil) {
            Text(game.homeTeam.fullName)
                .frame(maxWidth: 80, alignment: .leading)
            Spacer()
            
            Text("\(game.homeTeamScore)")
                .frame(maxWidth: 30, alignment: .leading)
            Spacer()
            
            Text(game.visitorTeam.fullName)
                .frame(maxWidth: 80, alignment: .leading)
            Spacer()
            
            Text("\(game.visitorTeamScore)")
                .frame(maxWidth: 30, alignment: .leading)
        }
    }
}

struct GamesViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GamesViewCell(game: Game(
            id: 1,
            homeTeam: Team(
                id: 1,
                city: "City1",
                conference: .east,
                fullName: "fullName1"
            ),
            homeTeamScore: 88,
            visitorTeam: Team(
                id: 2,
                city: "City2",
                conference: .west,
                fullName: "fullName2"
            ),
            visitorTeamScore: 77
        ))
    }
}
