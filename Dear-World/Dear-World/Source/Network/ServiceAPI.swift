//
//  DearWorldAPI.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import Alamofire
import Foundation

protocol ServiceAPI: URLRequestConvertible {
  associatedtype Response: Decodable
  
  var baseURL: URL { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: [String: Any]? { get }
}
extension ServiceAPI {
  var baseURL: URL {
    URL(string: "http://52.79.222.79/api/v1/")!
  }
  
  var parameters: [String: Any]? { nil }
  
  func asURLRequest() throws -> URLRequest {
    let url: URL = baseURL.appendingPathComponent(path)
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = method.rawValue
    switch method {
    case .post:
      request = try JSONEncoding.default.encode(request, with: parameters)
    default: ()
    }
    return request
  }
}
