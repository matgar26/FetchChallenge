//
//  ApiRequestClient.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation


extension ApiRequest {
    func sendRequest() async throws -> Response {
        
        let urlRequest = try buildRequest()
        
        guard let url = urlRequest.url else { throw ApiError.invalidUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(Response.self, from: data)
            case 401:
                throw ApiError.unauthorized("Request not authorized")
            case 403:
                throw ApiError.forbidden
            case 404:
                throw ApiError.notFound
            case 409:
                throw ApiError.conflict
            case 422:
                throw ApiError.unprocessable(data)
            case 429:
                throw ApiError.rateLimitted
            case 503:
                throw ApiError.serverBusy
            default:
                throw try ApiError.httpError(data: data)
            }
        } catch {
            var apiError: ApiError
            if let jsonErr = error as? EncodingError {
                apiError = ApiError.jsonEncoding(jsonErr)
            } else if let jsonErr = error as? DecodingError {
                apiError = ApiError.jsonDecoding(jsonErr)
            } else {
                apiError = ApiError.error(error)
            }
            #if DEBUG
            print(apiError)
            #endif
            throw apiError
        }
    }
    
    private func buildRequest() throws -> URLRequest {
        var components = URLComponents(string: NetworkingConfig.apiUrl)
        components?.path = "/api/json/v1/1/\(self.path)"
        components?.queryItems = self.queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let url = components?.url else { throw ApiError.invalidUrl }
        
        var apiRequest = URLRequest(
            url: url,
            cachePolicy: cachePolicy ?? .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: timeout ?? NetworkingConfig.defaultTimeoutLength
        )

        apiRequest.httpMethod = httpMethod.rawValue
        apiRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        apiRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return apiRequest
    }
}
