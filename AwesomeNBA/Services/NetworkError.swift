import Foundation

enum NetworkError: Error {
    
    case invalidUrl
    case invalidResponse
    case wrongStatus
    case failedToDecodeData
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "🔴 There was an error while creating the URL."
        case .invalidResponse:
            return "🔴🔴 Did not get a valid response."
        case .wrongStatus:
            return "🔴🔴🔴 Did not get a 2xx status code from the response."
        case .failedToDecodeData:
            return "🔴🔴🔴🔴 Failed to decode response into the given type."
        }
    }
    
}
