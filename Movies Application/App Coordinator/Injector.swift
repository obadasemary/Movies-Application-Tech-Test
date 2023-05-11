//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Alamofire

class Injector {
    
    private static var depenendecyResolver: DependencyResolver {
        return DependencyResolver()
    }
    
    static var mainServiceRepo: MainServicesRepoType = MainServicesRepo(
        localDS: depenendecyResolver.getMainServicesLocalDS(),
        remoteDS: depenendecyResolver.getMainServicesRemoteDS()
    )
}

