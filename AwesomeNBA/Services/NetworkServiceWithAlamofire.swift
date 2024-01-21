import Alamofire
import Foundation

protocol NetworkServiceWithAlamofireProtocol {
    
    func downloadGames(fromURL: String, completion: @escaping (Result<GamesPayload, Error>) -> ())
    
    func downloadGames(components: URLComponents, completion: @escaping (Result<GamesPayload, Error>) -> ())
}

final class NetworkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol {
    
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
    
    func downloadGames(components: URLComponents, completion: @escaping (Result<GamesPayload, Error>) -> ()) {
        
        guard let url = components.url else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        AF.request(url)
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
