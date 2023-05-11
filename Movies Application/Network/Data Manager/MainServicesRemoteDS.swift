//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Combine

class MainServicesRemoteDS: MainServicesRepoType {
    
    let context: RemoteContextRequestsProtocol
    var urlComponents = URLComponents()

    init(context: RemoteContextRequestsProtocol) {
        self.context = context
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "language": "en",
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.getPopularMovieList.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
			
        return publisher
    }
}
