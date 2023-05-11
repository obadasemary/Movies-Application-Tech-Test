//
//  Copyright © Modus Create. All rights reserved.
//

import XCTest
import Combine
@testable import Movies_Application

class PopularMoviesVMTests: XCTestCase {

	var sut: PopularMoviesVM!
	var mockRepo: MainServicesRepoTypeMock!
	var cancellables: Set<AnyCancellable> = []

	override func setUp() {
		super.setUp()
		mockRepo = MainServicesRepoTypeMock()
		sut = PopularMoviesVM(repo: mockRepo)
	}

	override func tearDown() {
		sut = nil
		mockRepo = nil
		cancellables.removeAll()
		super.tearDown()
	}

	func testGetPopularMovieList_Success() {
		// Given
		let expectedResponse = MovieListResponse(
			page: 1,
			totalResults: 2,
			totalPages: 2,
			results: [
				MovieSummary(
					id: 0,
					overview: "Ragnar Lothbrok, a legendary Norse hero, is a mere farmer who rises up to become a fearless warrior and commander of the Viking tribes with the support of his equally ferocious family.",
					posterPath: "vikings",
					releaseDate: "",
					title: "Vikings",
					voteAverage: 8.5
				),
				MovieSummary(
					id: 1,
					overview: "A criminal mastermind who goes by The Professor has a plan to pull off the biggest heist in recorded history -- to print billions of euros in the Royal Mint of Spain. To help him carry out the ambitious plan, he recruits eight people with certain abilities and who have nothing to lose. The group of thieves take hostages to aid in their negotiations with the authorities, who strategize to come up with a way to capture The Professor. As more time elapses, the robbers prepare for a showdown with the police.",
					posterPath: "moneyHeist",
					releaseDate: "",
					title: "Money Heist",
					voteAverage: 8.2
				)
			]
		)
		mockRepo.getPopularMovieListStub = Result.Publisher(expectedResponse).eraseToAnyPublisher()

		// Create an expectation
		let expectation = XCTestExpectation(description: "Fetch popular movie list")

		// When
		sut.getPopularMovieList()

		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			// Add this block to wait for the completion of the network request
			// and fulfill the expectation when the completion is called
			expectation.fulfill()

			// Perform assertions inside the completion block
			XCTAssertEqual(self.sut.popularMovies.count, 2, "Unexpected number of popular movies")
			XCTAssertEqual(self.sut.popularMovies, expectedResponse.results, "Popular movies not updated correctly")
			XCTAssertEqual(self.sut.popularMoviesTotalPages, 2, "Unexpected number of total pages")
			XCTAssertFalse(self.sut.popularMoviesIsLoadingPage, "isLoadingPage flag should be false")
		}

		// Wait for the expectation to be fulfilled
		wait(for: [expectation], timeout: 2)
	}

	func testGetPopularMovieList_Error() {
		// Given
		let expectedError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
		mockRepo.getPopularMovieListStub = Result.Publisher(expectedError).eraseToAnyPublisher()

		// When
		sut.getPopularMovieList()

		// Then
		XCTAssertEqual(sut.popularMovies.count, 0, "Popular movies should be empty")
		XCTAssertEqual(sut.popularMoviesTotalPages, 0, "Total pages should be 0")
	}

	// Create a mock class conforming to MainServicesRepoType for testing purposes
	class MainServicesRepoTypeMock: MainServicesRepoType {

		var getPopularMovieListStub: AnyPublisher<MovieListResponse, Error>?

		func getPopularMovieList(page: Int) -> AnyPublisher<Movies_Application.MovieListResponse, Movies_Application.APIError> {
			return getPopularMovieListStub!.mapError({ error in
				return Movies_Application.APIError.init(message: error.localizedDescription, errorCode: .badRequest)
			}).eraseToAnyPublisher()
		}

		func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, Error> {
			if let stub = getPopularMovieListStub {
				return stub
			} else {
				fatalError("getPopularMovieListStub should be set in the test")
			}
		}
	}
}
