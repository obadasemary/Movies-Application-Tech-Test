//
//  Copyright © Modus Create. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {
	var window: UIWindow?
	
	// swiftlint:disable:next discouraged_optional_collection
	func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		window = UIWindow()
		let popularMoviesViewController = PopularMoviesViewController()
		let navigationController = UINavigationController(rootViewController: popularMoviesViewController)

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}
}
