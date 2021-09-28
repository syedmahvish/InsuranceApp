import UIKit
import Alamofire

public enum ImageLoadingError: Error {
    case noImageFound
    case invalidResponse
}

public struct FetchImageResponse {
    public let image: UIImage
    public let requestUrlString : String
}

public final class DefaultImageManager: ImageManager {
    static let sharedInstance: DefaultImageManager = DefaultImageManager()
    let imageCache = NSCache<NSString, UIImage>()
    
    private init() {
    }
}

protocol ImageManager {
    var imageCache: NSCache<NSString, UIImage> { get }
}

extension UIImageView {
    
    public func loadImage(url: String,
                   placeholder: UIImage? = nil,
                   completionHandler: ((Result<FetchImageResponse, ImageLoadingError>) -> ())? = nil) {
        
        let imageCache = DefaultImageManager.sharedInstance.imageCache
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completionHandler?(.success(FetchImageResponse(image: cachedImage, requestUrlString: url)))
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success :
                    guard let validData = response.data,
                          let fetchedImage = UIImage(data: validData)
                    else {
                        completionHandler?(.failure(.noImageFound))
                        return
                    }
                    imageCache.setObject(fetchedImage, forKey: url as NSString)
                    completionHandler?(.success(FetchImageResponse(image: fetchedImage, requestUrlString: url)))
                case .failure :
                    completionHandler?(.failure(.invalidResponse))
                }
            }
    }
}

