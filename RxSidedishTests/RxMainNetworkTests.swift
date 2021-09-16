//
//  RxMainNetworkTests.swift
//  RxSidedishTests
//
//  Created by Issac on 2021/09/13.
//

import XCTest
@testable import RxSidedish
@testable import Alamofire
import RxBlocking

import RxSwift

class DummyRequestDelegate: RequestDelegate {
    var sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    var startImmediately: Bool = false
    func cleanup(after request: Request) {
    }
    func retryResult(for request: Request, dueTo error: AFError, completion: @escaping (RetryResult) -> Void) {
    }
    func retryRequest(_ request: Request, withDelay timeDelay: TimeInterval?) {
    }
}

class SessionManagerSpy: SessionManagerProtocol {
    var requestParameters: (url: URLConvertible, method: HTTPMethod)?
    
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: ((inout URLRequest) throws -> Void)?) -> DataRequest {
        
        self.requestParameters = (convertible, method)
        
        let delegate = DummyRequestDelegate()
        let request = URLRequest(url: URL(string: "https://www.google.com")!)
        
        return DataRequest.init(id: UUID(), convertible: request, underlyingQueue: DispatchQueue.global(), serializationQueue: DispatchQueue.main, eventMonitor: nil, interceptor: nil, delegate: delegate)
    }
    
    
}

class RxMainNetworkTests: XCTestCase {
    var networkManager: Networkable!
    var sessionManagerStub: SessionManagerSpy!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        sessionManagerStub = SessionManagerSpy()
        networkManager = NetworkManager(sessionManager: sessionManagerStub)
        disposeBag = DisposeBag()
        super.setUp()
    }
    
    func test_fetchSidedishes() {
        networkManager.get(type: SidedishItem.self, endpoint: .main)
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
        
        let params = sessionManagerStub.requestParameters
        
        XCTAssertEqual(try params?.url.asURL().absoluteString, "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main")
        XCTAssertEqual(params?.method, .get)
    }
}
