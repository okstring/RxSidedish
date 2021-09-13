//
//  SessionManagerProtocol.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/13.
//

import Foundation
import Alamofire

protocol SessionManagerProtocol {
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: ((inout URLRequest) throws -> Void)?) -> DataRequest
}

extension Session: SessionManagerProtocol {
    
}
