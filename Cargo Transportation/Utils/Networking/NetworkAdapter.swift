//
//  NetworkAdapter.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

let successHTTPCodesRange = 200...299
typealias NetworkParameters = [String: AnyHashable]
typealias NetworkHTTPHeaders = [String: String]

enum NetworkHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum NetworkResponse {
    case success(Data)
    case errors(ErrorsResponse)
    case failure(String)
}

extension NetworkResponse {
    func analysis(success: (Data) -> Void, errors: (ErrorsResponse) -> Void, failure: (String) -> Void) {
        switch self {
        case .success(let successData):
            success(successData)
        case .errors(let errorsResponse):
            errors(errorsResponse)
        case .failure(let error):
            failure(error)
        }
    }
}

struct ErrorsResponse {
    var errorsData: Data?
    var httpCode: Int?
    var requestKey: String?
    
    init(_ errorsData: Data?, _ httpCode: Int?, _ requestKey: String?) {
        self.errorsData = errorsData
        self.httpCode = httpCode
        self.requestKey = requestKey
    }
    
    init(errorsData: Data?, httpCode: Int?) {
        self.errorsData = errorsData
        self.httpCode = httpCode
    }
    
    func append(requestKey: String?) -> ErrorsResponse {
        return ErrorsResponse(self.errorsData, self.httpCode, requestKey)
    }
    
    func debugDescription() -> String {
        return "ErrorsResponse: requestKey - \(requestKey ?? "nil"), httpCode - \(String(describing: httpCode))"
    }
}

enum Encoding: Int {
    case URL
    case JSON
    case queryString
}

protocol NetworkAdapter: class {
    
    func request(url: URL,
                 httpMethod: NetworkHTTPMethod,
                 encoding: Encoding,
                 requestParameters: NetworkParameters?,
                 requestHeaders: NetworkHTTPHeaders?,
                 responseHandler: @escaping (NetworkResponse) -> Void)
}

enum Result<T, E> {
    case success(T)
    case failure(E)
    
    /// Return error value or nil if it doesn't exist
    var error: E? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
    
    /// Return success value or nil if it doesn't exist
    var value: T? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }
}


/// GeneralRepositoryComplition - Repository response result typealias
typealias GeneralNetworkCompletion<R, E> = (Result<R, E>) -> Void

/// GeneralCompletion - Repository response result typealias with predefined failure types - Error
typealias GeneralCompletion<R> = (Result<R, Error?>) -> Void

/// GeneralVoidCompletion - Repository response result typealias with predefined failure types - Error and success - Void
typealias GeneralVoidCompletion = (Result<Void, Error>) -> Void

enum NetworkError: Error {
    
    case general(String)
    
    /// Returns general error as String
    var desription: String? {
        if case let .general(value) = self {
            return value
        }
        return nil
    }
}
