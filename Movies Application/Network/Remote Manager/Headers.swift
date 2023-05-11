//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation

func headers() -> [String: String] {
    
    var headers = [String: String]()
    
    headers["Content-Type"] = "application/json;charset=utf-8"
    headers["Accept"] = "application/json"
    headers["X-OS-Name"] = "ios"
    headers["User-Agent"] = "iOSMobileApp"
    headers["Cache-Control"] = "no-cache"
    
    return headers
}
