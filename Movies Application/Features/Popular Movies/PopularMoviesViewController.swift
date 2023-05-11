//
//  Copyright © Modus Create. All rights reserved.
//

import UIKit
import Combine

private let reuseIdentifier = "Cell"

class PopularMoviesViewController: UICollectionViewController {

	@Published var vm = PopularMoviesVM(repo: Injector.mainServiceRepo)

	private var cencellableBag = [AnyCancellable]()
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
			let itemSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(0.5),
				heightDimension: .fractionalHeight(1)
			)
			let item = NSCollectionLayoutItem(layoutSize: itemSize)

			// Define group size
			let groupSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(UIScreen.main.bounds.width / 2 * 1.5)
			)
			let group = NSCollectionLayoutGroup.horizontal(
				layoutSize: groupSize,
				subitem: item,
				count: 2
			)
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

	private func setupLoadingView(isLoading: Bool) {
		title = isLoading ? "Loading ..." : "Popular"
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Popular"
		navigationItem.largeTitleDisplayMode = .always
		setupCollectionView()
		subscribeToViewModel()
		vm.getPopularMovieList()
	}

	private func subscribeToViewModel() {
		vm.$popularMoviesIsLoadingPage
			.receive(on: RunLoop.main)
			.sink { [weak self] isLoading in
				guard let self else { return }
				self.setupLoadingView(isLoading: isLoading)
			}.store(in: &cencellableBag)

		vm.$popularMovies
			.receive(on: RunLoop.main)
			.sink { [weak self] moviesArray in
				guard let self else { return }
				self.collectionView.reloadData()
			}.store(in: &cencellableBag)
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PopularMoviesViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.vm.popularMovies.count
	}

	override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		let itemIndex = indexPath.item

		let isLastItem = (vm.popularMovies.count - 1) == itemIndex

		if isLastItem { vm.getPopularMovieList() }
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularMovieCell

		// Configure the cell with the appropriate MovieSummary
		let movieSummary = self.vm.popularMovies[indexPath.item]
		cell.summary = movieSummary

		return cell
	}
}
