//
//  ImageLoader.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


final class ImageLoader {
    static private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    static func load(from imageURL: String, completionHandler: @escaping (UIImage?) -> ()) -> DownloadRequest? {
        guard let fileName = URL(string: imageURL)?.lastPathComponent else {
            return nil
        }

        if let cache = availableCache(of: fileName) {
            let image = UIImage(contentsOfFile: cache)

            DispatchQueue.main.async {
                completionHandler(image)
                return
            }
        }

        let request = downloadRequest(of: imageURL, fileName: fileName)
        request.responseURL { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                let image = UIImage(contentsOfFile: filePath)

                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }
        }
        return request
    }
    
    static func rxLoad(from imageURL: String) -> Driver<UIImage?> {
        return Observable.create{ emitter in
            guard let fileName = URL(string: imageURL)?.lastPathComponent else {
                emitter.onError(NetworkError.imageURL)
                return Disposables.create()
            }
            
            if let cache = availableCache(of: fileName) {
                let image = UIImage(contentsOfFile: cache)
                
                emitter.onNext(image)
                return Disposables.create()
            }

            let request = downloadRequest(of: imageURL, fileName: fileName)
            request.responseURL { response in
                if response.error == nil, let filePath = response.fileURL?.path {
                    let image = UIImage(contentsOfFile: filePath)

                    emitter.onNext(image)
                }
            }
            return Disposables.create()
        }.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
        .asDriver(onErrorJustReturn: nil)
    }
    
    static private func availableCache(of fileName: String) -> String? {
        let expectedPath = cacheURL.path + "/\(fileName)"
        return FileManager.default.fileExists(atPath: expectedPath) ? expectedPath : nil
    }

    static private func downloadRequest(of imageURL: String, fileName: String) -> DownloadRequest {
        let destination: DownloadRequest.Destination = { _,_ in
            let fileURL = self.cacheURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return AF.download(imageURL, to: destination)
    }
}


