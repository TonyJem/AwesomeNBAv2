import Foundation

enum NetworkError: Error {
    
    // TODO: Check if all error are in use
    // Check naming and proper description for each error
    // Should we add more or there are some redundant errors?
    case invalidUrl
    case invalidRequest
    case badResponse
    case wrongStatus
    case failedToDecodeResponse
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "🔴 There was an error creating the URL"
        case .invalidRequest:
            return "🔴🔴 invalidRequest"
        case .badResponse:
            return "🔴🔴 Did not get a valid response"
        case .wrongStatus:
            return "🔴🔴🔴 Did not get a 2xx status code from the response"
        case .failedToDecodeResponse:
            return "🔴🔴🔴🔴 Failed to decode response into the given type"
        }
    }
}
