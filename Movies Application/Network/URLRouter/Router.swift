//
//  Copyright © Modus Create. All rights reserved.
//
//  Source of this file
//  https://github.com/chaione/RoutableApp

import Foundation

var defaultUrlParams: [String: String] {
    return [
        "api_key": apiURLConstants.apiKey
    ]
}

enum apiURLConstants {
    
    static let apiURL = "https://api.themoviedb.org/3"
    static let apiKey = "44258121c0a1dbc3f3859f7f4b32bb07"
}


struct Router: URLRouter {
    
    static var basePath: String {
        return apiURLConstants.apiURL
    }
    
    struct getPopularMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/popular"
    }
}
