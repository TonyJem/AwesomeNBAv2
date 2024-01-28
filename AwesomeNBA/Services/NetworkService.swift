import Foundation

protocol NetworkServiceProtocol: Codable {
    
    func fetchData<T: Codable>(components: URLComponents) async throws -> T
    
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Codable>(components: URLComponents) async throws -> T {
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.wrongStatus
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.failedToDecodeData
        }
        
        return decodedData
    }
    
}
