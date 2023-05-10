//
//  Copyright © Modus Create. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PopularMoviesViewController: UICollectionViewController {

	init() {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = .zero
		layout.itemSize = CGSize(width: 320, height: 100)
		layout.minimumInteritemSpacing = 1
		layout.minimumLineSpacing = 1
		super.init(collectionViewLayout: layout)
	}

	private func setupCollectionView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
		collectionView.backgroundColor = .systemBackground
		collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	}

	private func setupCollectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
			// Define item size
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)

			// Define group size
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIScreen.main.bounds.width / 2 * 1.5))
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
			group.interItemSpacing = .fixed(20) // Adjust the horizontal spacing between cells

			// Create section
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = -10 // Adjust the vertical spacing between cells

			// Add section insets for padding
			let horizontalPadding: CGFloat = 20
			let verticalPadding: CGFloat = 10
			section.contentInsets = NSDirectionalEdgeInsets(
				top: verticalPadding,
				leading: horizontalPadding,
				bottom: verticalPadding,
				trailing: horizontalPadding
			)

			// Return section
			return section
		}

		return layout
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Popular"
		navigationItem.largeTitleDisplayMode = .always

		setupCollectionView()
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PopularMoviesViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return MovieSummary.examples.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularMovieCell

		// Configure the cell with the appropriate MovieSummary
		let movieSummary = MovieSummary.examples[indexPath.item]
		cell.summary = movieSummary

		return cell
	}
}
