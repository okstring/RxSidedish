//
//  APIService.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/30.
//

import Foundation
import RxSwift
import Alamofire

struct ServerAPI {
    static let baseURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan"
    enum Endpoint {
        case main
        case soup
        case side
        case detail(String)
        
        var path: String {
            switch self {
            case .detail(let hash): return "/detail/\(hash)"
            default: return "/\(self)"
            }
        }
    }
}

enum NetworkError: Error {
    case internet
    case noResult
    case redirection
    case notAllowed
    case server
    case unknown
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .internet:
            return "인터넷 연결을 확인해주세요"
        case .noResult:
            return "검색 결과를 찾을 수 없습니다"
        case .redirection:
            return "리다이렉션으로 추가 후속 조치가 필요합니다"
        case .notAllowed:
            return "잘못된 접근입니다"
        case .server:
            return "서버 상태가 불안정합니다"
        case .unknown:
            return "알 수 없는 문제가 발생했습니다"
        }
    }
}

class NetworkManager {
    func get<T: Decodable>(type: T.Type,
                           endpoint: ServerAPI.Endpoint) -> Observable<T> {
        let url = "\(ServerAPI.baseURL)\(endpoint.path)"
        return Observable.create() { emitter in
            AF.request(url,
                       method: .get)
                .responseDecodable(of: type) { (dataResponse) in
                    guard let statusCode = dataResponse.response?.statusCode else {
                        return emitter.onError(NetworkError.internet)
                    }
                    print(dataResponse.value, dataResponse.response, dataResponse.error)
                    switch statusCode {
                    case 200..<300:
                        guard let result = dataResponse.value else {
                            return emitter.onError(NetworkError.noResult)
                        }
                        emitter.onNext(result)
                    case 300..<400:
                        emitter.onError(NetworkError.redirection)
                    case 400..<500:
                        emitter.onError(NetworkError.notAllowed)
                    case 500...:
                        emitter.onError(NetworkError.server)
                    default:
                        emitter.onError(NetworkError.unknown)
                    }
                }
            return Disposables.create()
        }
    }
}
//func request<T: Decodable>(decodingType: T.Type,
//                           endPoint: ServerAPI.Endpoint,
//                           method: HTTPMethod,
//                           parameters: [String: Any]? = nil,
//                           headers: HTTPHeaders? = nil,
//                           isJSONEncoding: Bool = true,
//                           completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
//    let address = baseAddress + endPoint.value
//    let decoder = JSONDecoder()
//    let encoding: ParameterEncoding = isJSONEncoding ? JSONEncoding.default : URLEncoding.default
//    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
//    AF.request(address,
//               method: method,
//               parameters: parameters,
//               encoding: encoding,
//               headers: self.baseHeaders)
//        .responseDecodable(of: decodingType, decoder: decoder) { dataResponse in
//            guard let statusCode = dataResponse.response?.statusCode else {
//                return completionHandler(.failure(NetworkError.internet))
//        }
//        switch statusCode {
//        case 200..<300:
//            guard let data = dataResponse.value else {
//                return completionHandler(.failure(NetworkError.noResult))
//            }
//            completionHandler(.success(data))
//        case 300..<400:
//            completionHandler(.failure(NetworkError.noResult))
//        case 400..<500:
//            completionHandler(.failure(NetworkError.notAllowed))
//        case 500...:
//            completionHandler(.failure(NetworkError.server))
//        default:
//            completionHandler(.failure(NetworkError.unknown))
//        }
//    }
//}
//
////
////  ImageLoader.swift
////  IssueTracker
////
////  Created by Issac on 2021/06/22.
////
//
//import UIKit
//import Alamofire
//
//final class ImageLoader {
//    static private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//    static func load(from imageUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
//        guard let fileName = URL(string: imageUrl)?.lastPathComponent else { return }
//
//        if let cache = availableCache(of: fileName) {
//            let image = UIImage(contentsOfFile: cache)
//
//            DispatchQueue.main.async {
//                return completionHandler(image)
//            }
//        }
//
//        let request = downloadRequest(of: imageUrl, fileName: fileName)
//        request.responseURL { response in
//            if response.error == nil, let filePath = response.fileURL?.path {
//                let image = UIImage(contentsOfFile: filePath)
//
//                DispatchQueue.main.async {
//                    return completionHandler(image)
//                }
//            }
//        }
//    }
//
//    static func just(from imageUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
//        AF.request(imageUrl).responseData { (response) in
//            if let data = response.data {
//                let image = UIImage(data: data)
//                completionHandler(image)
//            }
//        }
//    }
//
//    static private func availableCache(of fileName: String) -> String? {
//        let expectedPath = cacheURL.path + "/\(fileName)"
//        return FileManager.default.fileExists(atPath: expectedPath) ? expectedPath : nil
//    }
//
//    static private func downloadRequest(of imageURL: String, fileName: String) -> DownloadRequest {
//        let destination: DownloadRequest.Destination = { _,_ in
//            let fileURL = self.cacheURL.appendingPathComponent(fileName)
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//        return AF.download(imageURL, to: destination)
//    }
//
//}
