//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Alamofire

class DependencyResolver: NSObject {

    var session: SessionManager?
    var remoteContext: RemoteContext?
    var localContext: LocalContext?
    
    private func getSessionManager() -> SessionManager {
        guard let session = session else {
            let adapter = AccessTokenAdapter()
            let session = SessionManager(adapter: adapter)
            return session
        }
        return session
    }
    
    func getRemoteContext() -> RemoteContext {
        guard let context = self.remoteContext else {
            let context = RemoteContext(session: getSessionManager())
            return context
        }
        return context
    }
    
    func getLocalContext() -> LocalContext {
        guard let context = self.localContext else {
            let context = LocalContext()
            return context
        }
        return context
    }
    
    func getMainServicesLocalDS() -> MainServicesRepoType {
        let localDS = MainServiceLocalDS(context: getLocalContext())
        return localDS
    }
    
    func getMainServicesRemoteDS() -> MainServicesRepoType {
        let localDS = MainServicesRemoteDS(context: getRemoteContext())
        return localDS
    }
}
