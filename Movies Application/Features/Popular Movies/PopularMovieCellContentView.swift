//
//  Copyright © Modus Create. All rights reserved.
//

import SwiftUI

extension PopularMovieCell {
	struct ContentView: View {
		let summary: MovieSummary
		
		var body: some View {
			ZStack(alignment: .bottomLeading) {
				//				AsyncImage(url: URL(string: "")) { image in
				//						image.resizable()
				//								.aspectRatio(contentMode: .fill)
				//								.frame(width: 160, height: 250)
				//								.cornerRadius(30)
				//				} placeholder: {
				//						Rectangle()
				//								.foregroundColor(.gray.opacity(0.3))
				//								.frame(width: 160, height: 250)
				//								.cornerRadius(30)
				//				}
				Image(summary.posterPath)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 * 1.5 - 20)
					.cornerRadius(30)

				HStack(alignment: .center) {

					VStack(alignment: .leading) {
						Text(summary.title)
							.font(.caption)
							.bold()

						Text(summary.overview)
							.font(.caption2)
							.italic()
							.multilineTextAlignment(.leading)
					}
					.lineLimit(3)
					.frame(width: UIScreen.main.bounds.width / 4.0 - 20)
					.foregroundColor(.white)
					.shadow(radius: 20)
					.padding(.leading)

					UserScoreView(progress: CGFloat(summary.voteAverage), boxSize: 50)
				}
			}
			.padding()
		}
	}
}

struct PopularMovieCellContentView_Previews: PreviewProvider {
	static var previews: some View {
		PopularMovieCell.ContentView(summary: .examples.first!)
			.previewLayout(.fixed(width: 200, height: 350))
	}
}
