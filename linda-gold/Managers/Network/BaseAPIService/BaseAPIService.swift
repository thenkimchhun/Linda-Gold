//
//  BaseAPIService.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 8/15/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

protocol APIService {
    associatedtype ProviderType: TargetType
}
/// All the api request services need to implement from BaseApiService
/// <T>:  is a Provider Type or Resource Type

class BaseAPIService<T>: APIService where T: TargetType {
    typealias ProviderType = T
    
    private var task: URLSessionTask?
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<U: Codable>(service: ProviderType, model: U.Type, completion: @escaping (NetworkResponse<U>) -> ()) where U: Codable {
        if !Connectivity.isConnectedToNetwork.1 {
            let apiResponse = APIResponseError(statusCode: -1, message: "No Internet connection found. Check your connection or try again")
            completion(.failure(apiResponse))
            return
        }
        
        do {
            let request = try buildRequest(from: service)
             NetworkLogger.log(request: request)
            task = session.dataTask(request: request) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                var apiResponseError = APIResponseError(statusCode: 404, message: "Something went wrong. Please try again later.")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(apiResponseError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    guard let data = data else { return }
                    do {
                        let result = try JSONDecoder().decode(U.self, from: data)
                        completion(.success(result))
                    } catch let decodingError as DecodingError {
                        self.handleDecodingError(decodingError, apiResponseError: &apiResponseError)
                        completion(.failure(apiResponseError))
                    } catch {
                        completion(.failure(apiResponseError))
                    }
                default:
                    completion(.failure(decode(modelType: APIResponseError.self, data: data)))
                }
            }
            
            task?.resume()
        } catch {
            // Handle the error gracefully, e.g., throw or call completion with failure result
            fatalError()
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from providerType: ProviderType) throws -> URLRequest {
        var request = URLRequest(
            url: providerType.baseUrl.appendingPathComponent(providerType.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = providerType.method.rawValue
        
        do {
            switch providerType.task {
            case .requestPlain:
                requestHeaders(service: providerType, request: &request)
                
            case .requestParameters(bodyParameters: let bodyParameters,
                                    bodyEncoding: let bodyEncoding,
                                    urlParameters: let urlParameters):
                requestHeaders(service: providerType, request: &request)
                try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Encodable?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func requestHeaders(service: TargetType, request: inout URLRequest) {
        service.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func handleDecodingError(_ decodingError: DecodingError, apiResponseError: inout APIResponseError) {
        switch decodingError {
        case .typeMismatch(let type, let context):
            apiResponseError.message = "Type mismatch"
            handlePrintingDecodingError(type: type, rawString: apiResponseError.message, context: context)
            
        case .valueNotFound(let value, let context):
            apiResponseError.message = "Value not found"
            handlePrintingDecodingError(type: value, rawString: apiResponseError.message, context: context)
            
        case .keyNotFound(let key, let context):
            apiResponseError.message = "Key not found"
            handlePrintingDecodingError(type: key, rawString: apiResponseError.message, context: context)
            
        case .dataCorrupted(let context):
            handlePrintingDecodingError(type: "", rawString: "", context: context)
            
        @unknown default:
            break
        }
    }
    
    private func handlePrintingDecodingError(type: Any, rawString: String, context: DecodingError.Context) {
        print("\(type) \(rawString): ", context.debugDescription)
        print("codingPath: ", context.codingPath)
    }
    
    private func decode<U: Codable>(modelType: U.Type, data: Data?) -> U? where U : Decodable {
        guard let data = data else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode(modelType.self, from: data)
            return decodedData
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
