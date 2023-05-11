//
//  Copyright © Modus Create. All rights reserved.
//
//  https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md

import Foundation
import Alamofire

class SessionManager: NSObject {
    
    var session: Session!
    
    init(adapter: AccessTokenAdapter) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringCacheData //ephemeral: means no caching or cookies at all
        //so we use TrustKit for pinning which uses the server's public keys instead of cert files (we set them in AppDelegate)
        self.session = Alamofire.Session(configuration: configuration, interceptor: adapter)
    }
}

class RemoteSessionDelegate: SessionDelegate {
    override func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
}
