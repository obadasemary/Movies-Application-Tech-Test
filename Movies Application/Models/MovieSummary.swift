//
//  Copyright © Modus Create. All rights reserved.
//

import Foundation

// MARK: - MovieListResponse
public struct MovieListResponse: Codable {

		let page, totalResults, totalPages: Int?
		let results: [MovieSummary]?

		enum CodingKeys: String, CodingKey {
				case page
				case totalResults = "total_results"
				case totalPages = "total_pages"
				case results
		}
}


public struct MovieSummary: Codable {
	public let id: Int?
	public let overview: String?
	public let posterPath: String?
	public let releaseDate: String?
	public let title: String?
	public let voteAverage: Double?
	
	public var isPopular: Bool {
		voteAverage ?? 0 >= 7.0
	}
	
	public var thumbnailURL: URL {
		guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w300") else {
			preconditionFailure("Unable to build URL")
		}
		return baseURL.appendingPathComponent(posterPath ?? "")
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case overview
		case posterPath = "poster_path"
		case releaseDate = "release_date"
		case title
		case voteAverage = "vote_average"
	}
}

extension MovieSummary: Hashable {}

public extension MovieSummary {
	static let examples = [
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
		),
		MovieSummary(
			id: 2,
			overview: "When a mysterious attack kills the president and wipes out everybody in the line of succession, Thomas Kirkman, a lowly cabinet minister, is forced to rise to the occasion as the designated survivor.",
			posterPath: "survivor",
			releaseDate: "",
			title: "Designated Survivor",
			voteAverage: 7.5
		),
		MovieSummary(
			id: 3,
			overview: "A wanted fugitive mysteriously surrenders himself to the FBI and offers to help them capture deadly criminals. His sole condition is that he will work only with the new profiler, Elizabeth Keen.",
			posterPath: "blackList",
			releaseDate: "",
			title: "The Blacklist",
			voteAverage: 8
		),
		MovieSummary(
			id: 4,
			overview: "During World War I, two British soldiers -- Lance Cpl. Schofield and Lance Cpl. Blake -- receive seemingly impossible orders. In a race against time, they must cross over into enemy territory to deliver a message that could potentially save 1,600 of their fellow comrades -- including Blake's own brother.",
			posterPath: "1917",
			releaseDate: "",
			title: "1917",
			voteAverage: 8.2
		),
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
		),
		MovieSummary(
			id: 2,
			overview: "When a mysterious attack kills the president and wipes out everybody in the line of succession, Thomas Kirkman, a lowly cabinet minister, is forced to rise to the occasion as the designated survivor.",
			posterPath: "survivor",
			releaseDate: "",
			title: "Designated Survivor",
			voteAverage: 7.5
		),
		MovieSummary(
			id: 3,
			overview: "A wanted fugitive mysteriously surrenders himself to the FBI and offers to help them capture deadly criminals. His sole condition is that he will work only with the new profiler, Elizabeth Keen.",
			posterPath: "blackList",
			releaseDate: "",
			title: "The Blacklist",
			voteAverage: 8
		),
		MovieSummary(
			id: 4,
			overview: "During World War I, two British soldiers -- Lance Cpl. Schofield and Lance Cpl. Blake -- receive seemingly impossible orders. In a race against time, they must cross over into enemy territory to deliver a message that could potentially save 1,600 of their fellow comrades -- including Blake's own brother.",
			posterPath: "1917",
			releaseDate: "",
			title: "1917",
			voteAverage: 8.2
		)
	]
}
