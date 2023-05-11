//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation
import Combine

class PopularMoviesVM: ObservableObject {

	let repo: MainServicesRepoType
	private var cancellables: Set<AnyCancellable> = []
	@Published var popularMoviesResponse: MovieListResponse?

	@Published var popularMovies: [MovieSummary] = []

	var popularMoviesPage: Int = 1
	var popularMoviesTotalPages: Int = 0
	@Published var popularMoviesIsLoadingPage = false
	private var popularMoviesCanLoadMorePages = true

	init(repo: MainServicesRepoType) {
			self.repo = repo
	}

	func getPopularMovieList() {
			guard !popularMoviesIsLoadingPage && popularMoviesCanLoadMorePages else {
					return
			}

			popularMoviesIsLoadingPage = true

			self.repo.getPopularMovieList(page: popularMoviesPage)
					.handleEvents(receiveSubscription: { (sub) in
							print("sub", sub)
					}, receiveOutput: { (output) in
							print("output getPopularMovieList", output)
					}, receiveCompletion: { (c) in
							print("completion", c)
					}, receiveCancel: {
							print("cancel is recieved")
					}, receiveRequest: { (request) in
							print("request", request)
					})
					.delay(for: 1, scheduler: RunLoop.main)
					.sink { (completion) in } receiveValue: { [weak self] (model) in

							guard let self = self else { return }

							self.popularMoviesPage += 1
							self.popularMoviesIsLoadingPage = false
							self.popularMoviesResponse = model
							self.popularMovies.append(contentsOf: model.results ?? [])
							self.popularMoviesTotalPages = model.totalPages ?? 0

					}.store(in: &cancellables)
	}
}
