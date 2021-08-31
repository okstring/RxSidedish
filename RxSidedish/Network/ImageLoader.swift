//
//  ImageLoader.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import Alamofire

final class ImageLoader {
    static private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    static func load(from imageUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
        guard let fileName = URL(string: imageUrl)?.lastPathComponent else { return }

        if let cache = availableCache(of: fileName) {
            let image = UIImage(contentsOfFile: cache)

            DispatchQueue.main.async {
                return completionHandler(image)
            }
        }

        let request = downloadRequest(of: imageUrl, fileName: fileName)
        request.responseURL { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                let image = UIImage(contentsOfFile: filePath)

                DispatchQueue.main.async {
                    return completionHandler(image)
                }
            }
        }
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


