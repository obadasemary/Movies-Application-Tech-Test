//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Combine

protocol MainServicesRepoType {

    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
}

final class MainServicesRepo: MainServicesRepoType {
    
    var remoteDS: MainServicesRepoType
    var localDS: MainServicesRepoType
    
    init(localDS: MainServicesRepoType, remoteDS: MainServicesRepoType) {
        self.localDS = localDS
        self.remoteDS = remoteDS
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getPopularMovieList(page: page)
    }
}
