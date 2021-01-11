//
//  Network.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2020/12/27.
//

import Alamofire
import Foundation
import RxSwift

enum Network {
  static var isDebug: Bool = false
  
  static func request<API: ServiceAPI>(_ endpoint: API) -> Observable<API.Response?> {
    .create { observer in
      AF.request(endpoint)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ResponseWrapper<API.Response>.self) { result in
          if isDebug {
            Logger.log(result)
          }
          switch result.result {
          case .success(let response):
            if let error: NetworkError = NetworkError(code: response.code, message: response.message) {
              observer.onError(error)
            } else {
              observer.onNext(response.data)
              observer.onCompleted()
            }
          case .failure(let error):
            observer.onError(error)
          }
        }
      return Disposables.create()
    }
  }
}
