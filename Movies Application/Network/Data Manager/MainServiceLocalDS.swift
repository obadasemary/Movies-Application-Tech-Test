//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Combine

class MainServiceLocalDS: MainServicesRepoType {
    
    var context: LocalContext

    init(context: LocalContext) {
        self.context = context
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
}
