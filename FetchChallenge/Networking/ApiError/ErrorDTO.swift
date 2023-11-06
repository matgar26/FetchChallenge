//
//  ErrorDTO.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation

public struct ErrorDto: Decodable {
    var timestamp: Date?
    var status: HttpStatus?
    var error: String?
    var message: String?
    var path: String?
    var errors: [ErrorDetailDto]?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case status
        case error
        case message
        case path
        case errors
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try? values.decodeIfPresent(Date.self, forKey: .timestamp)
        status = HttpStatus(rawValue: try? values.decodeIfPresent(Int.self, forKey: .status))
        error = try? values.decodeIfPresent(String.self, forKey: .error)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        path = try? values.decodeIfPresent(String.self, forKey: .path)
        errors = try? values.decodeIfPresent([ErrorDetailDto].self, forKey: .errors)
    }
}

public struct ErrorDetailDto: Codable {
    var defaultMessage: String?
    var objectName: String?
    var field: String?
    var rejectedValue: String?
    var bindingFailure: Bool?
    var code: String?
    var codes: [String]?
    var arguments: [ErrorDetailArgumentDto]?
}

public struct ErrorDetailArgumentDto: Codable {
    var defaultMessage: String?
    var code: String?
    var codes: [String]?
}

public enum HttpStatus: Int {
    // have to explicitly include this to have multiple rawValue inits
    public typealias RawValue = Int

    case unknown = 0
    case success = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case unprocessable = 422
    case serverError = 500

    public init(rawValue: Int) {
        switch rawValue {
        case 200: self = .success
        case 201: self = .created
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 409: self = .conflict
        case 422: self = .unprocessable
        case 500: self = .serverError
        default: self = .unknown
        }
    }

    public init(rawValue: Int?) {
        self.init(rawValue: rawValue ?? 0)
    }
}
