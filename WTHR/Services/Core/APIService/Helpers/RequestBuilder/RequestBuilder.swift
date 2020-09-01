//
//  RequestBuilder.swift
//  WTHR
//
//  Created by Гена Книжник on 16.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

protocol Route {
    
    var path: String { get }
    
}

struct RequestBuilder {
    
    struct BaseParams {
        
        enum Key: String {
            
            case appId = "appid"
            
        }
        
        let dictionary: [Key: String]
        
        var queryItems: [URLQueryItem] {
            dictionary.map { URLQueryItem(name: $0.key.rawValue, value: $0.value) }
        }
        
    }
    
    // MARK: - Stored Properties
    
    private let baseURL: String
    private let baseQueryItems: [URLQueryItem]
    
    // MARK: - Init
    
    init(baseURL: String, baseParams: BaseParams) {
        self.baseURL = baseURL
        baseQueryItems = baseParams.queryItems
    }
    
    // MARK: -  Requests
    
    func absoluteURL(route: Route, queryItems: [URLQueryItem] = []) -> URL? {
        let endpoint = baseURL + route.path
        guard let url = URL(string: endpoint), var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = baseQueryItems + queryItems
        return urlComponents.url
    }
    
    func getRequest(for url: URL?) -> URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url)
    }
    
}
