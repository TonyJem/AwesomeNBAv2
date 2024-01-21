import Alamofire
import Foundation

protocol NetworkServiceWithAlamofireProtocol {
    
    func downloadTeams(fromURL: String, completion: @escaping (Result<TeamsPayload, Error>) -> ())
    
    func downloadGames(fromURL: String, completion: @escaping (Result<GamesPayload, Error>) -> ())
    
}

final class NetworkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol {

    func downloadTeams(fromURL: String, completion: @escaping (Result<TeamsPayload, Error>) -> ()) {
        AF.request(fromURL)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let userResults = try? JSONDecoder().decode(TeamsPayload.self, from: data) else {
                    completion(.failure(NetworkError.failedToDecodeResponse))
                    return
                }
                completion(.success(userResults))
            }
    }
    
    func downloadGames(fromURL: String, completion: @escaping (Result<GamesPayload, Error>) -> ()) {
        AF.request(fromURL)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let gamesResults = try? JSONDecoder().decode(GamesPayload.self, from: data) else {
                    completion(.failure(NetworkError.failedToDecodeResponse))
                    return
                }
                completion(.success(gamesResults))
            }
    }
    
}
