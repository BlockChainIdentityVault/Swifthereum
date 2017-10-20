//
//  Resource.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/11/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get =      "GET"
    case post =     "POST"
    case put =      "PUT"
    case patch =    "PATCH"
    case delete =   "DELETE"
    case head =     "HEAD"
}

public enum ParameterEncoding {
    case json
    /// Only use for GET, DELETE, and HEAD methods
    case url
    /// Only use for POST, PUT, PATCH methods
    case body
    
    public func contentType() -> String {
        switch self {
        case .json:
            return "application/json"
        case .url, .body:
            return "application/x-www-form-urlencoded"
        }
    }
}

public struct Resource<A: Decodable> {
    
    public let server: Server
    public let rpcMethod: String               // E.g. "web3_clientVersion"
    public let headers: JSONDictionary?
    public let parameters: JSONDictionary?     // [params: ...]
    public let httpMethod: HttpMethod
    public let encoding: ParameterEncoding
    /**
         Called by NetworkService to parse the data returned from the server. Depending on the kind of data we expect (e.g. JSON vs an image) we can set a suitable closure in the init.
     */
    public let parse: (Data) throws -> A?
}

extension Resource {
    
    public init(server: Server, rpcMethod: String, headers: JSONDictionary? = nil, parameters: JSONDictionary? = nil, httpMethod: HttpMethod = .post, encoding: ParameterEncoding = .json) {
        self.server = server
        self.rpcMethod = rpcMethod
        self.headers = headers
        self.parameters = parameters
        self.httpMethod = httpMethod
        self.encoding = encoding
        parse = { data in
            let encodedData = try JSONDecoder().decode(A.self, from: data)
            return encodedData
        }
    }
}
