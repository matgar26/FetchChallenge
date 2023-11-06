//
//  ApiRequest.swift
//  FetchChallenge
//
//  Created by Matt Gardner on 11/4/23.
//

import Foundation


protocol ApiRequest {
    associatedtype Response: Decodable

    var path: String { get }
    var httpMethod: HttpMethod { get }

    // allow override of default values
    var cachePolicy: NSURLRequest.CachePolicy? { get }
    var timeout: TimeInterval? { get }
    var queryItems: [String: String] { get }
}

extension ApiRequest {
    var cachePolicy: NSURLRequest.CachePolicy? { return nil }
    var timeout: TimeInterval? { return nil }
    var queryItems: [String: String] { [:] }
}

protocol APIBody {
    associatedtype Body: Encodable
    var bodyData: Body { get }
}


protocol ApiRequestGet: ApiRequest {}

extension ApiRequestGet {
    var httpMethod: HttpMethod { .GET }
}

protocol ApiRequestPost: ApiRequest, APIBody {}
extension ApiRequestPost {
    var httpMethod: HttpMethod { .POST }
}

protocol ApiRequestPut: ApiRequest, APIBody {}
extension ApiRequestPut {
    var httpMethod: HttpMethod { .PUT }
}

protocol ApiRequestPatch: ApiRequest, APIBody {}
extension ApiRequestPatch {
    var httpMethod: HttpMethod { .PATCH }
}

protocol ApiRequestDelete: ApiRequest where Response == VoidModel {
    var bodyData: Encodable? { get }
}
extension ApiRequestDelete {
    var httpMethod: HttpMethod { .DELETE }
    var cachePolicy: NSURLRequest.CachePolicy? { .reloadIgnoringLocalAndRemoteCacheData }
    var bodyData: Encodable? { nil }
}

public struct VoidModel: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        self.init()
    }
}
