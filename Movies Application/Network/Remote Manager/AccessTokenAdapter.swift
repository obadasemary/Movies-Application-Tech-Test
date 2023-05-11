//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let urlRequest = urlRequest
        completion(.success(urlRequest))
    }

    func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            print("renew refresh: ",error, " ", request.request?.url?.lastPathComponent ?? "-/-")
            completion(.doNotRetry)
        } else {
            completion(.doNotRetry)
        }
    }
}
