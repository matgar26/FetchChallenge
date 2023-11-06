//
//  ApiError.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

public enum ApiError: LocalizedError, CustomStringConvertible {
    case runtimeError(String)
    case jsonEncoding(EncodingError)
    case jsonDecoding(DecodingError)
    case invalidResponse
    case rateLimitted
    case serverBusy
    case httpError(ErrorDto)
    case unauthorized(String)
    case forbidden
    case conflict
    case notFound
    case invalidUrl
    case unprocessable(Data)

    public var description: String {
        switch self {
        case .runtimeError(let msg), .unauthorized(let msg): return msg
        case .invalidResponse: return "Failed to convert response to HTTPURLResponse"
        case .rateLimitted: return "Client has made too many requests in a short time"
        case .serverBusy: return "Server was busy"
        case .httpError(let dto): return dto.message ?? "Unknown API error"
        case .jsonDecoding(let err): return decodingString(err)
        case .jsonEncoding(let err): return encodingString(err)
        case .forbidden: return "Forbidden"
        case .conflict: return "Conflict"
        case .notFound: return "Not Found"
        case .unprocessable: return "Unprocessable Entity"
        case .invalidUrl: return "Invalid Url"
        }
    }

    public var localizedDescription: String {
        description
    }

    private func decodingString(_ err: DecodingError) -> String {
        switch err {
        case let .valueNotFound(_, ctx),
             let .typeMismatch(_, ctx),
             let .keyNotFound(_, ctx),
             let .dataCorrupted(ctx):
            return "\(ctx.codingPath.description) - \(ctx.debugDescription)"

        @unknown default:
            return err.localizedDescription
        }
    }

    private func encodingString(_ err: EncodingError) -> String {
        switch err {
        case let .invalidValue(_, ctx):
            return "\(ctx.codingPath.description) - \(ctx.debugDescription)"

        @unknown default:
            return err.localizedDescription
        }
    }

    static func httpError(data: Data) throws -> ApiError {
        let dto = try JSONDecoder().decode(ErrorDto.self, from: data)
        return .httpError(dto)
    }

    static func error(_ err: Error) -> ApiError {
        ApiError.runtimeError(err.localizedDescription)
    }
}
