import Foundation

protocol NetworkServiceProtocol: Codable {
    
    func fetchData<T: Codable>(components: URLComponents) async -> T?
    
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Codable>(components: URLComponents) async -> T? {
        do {
            guard let url = components.url else { throw NetworkError.invalidUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.wrongStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.invalidUrl {
            print("🔴 There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("🔴🔴 Did not get a valid response")
        } catch NetworkError.wrongStatus {
            print("🔴🔴🔴 Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("🔴🔴🔴🔴 Failed to decode response into the given type")
        } catch {
            print("🔴🔴🔴🔴🔴 An error occured downloading the data")
        }
        
        return nil
    }
    
}
