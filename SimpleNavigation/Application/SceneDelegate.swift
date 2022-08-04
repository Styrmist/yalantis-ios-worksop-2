import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        window = (scene as? UIWindowScene).map(UIWindow.init(windowScene:))
        window?.rootViewController = UIHostingController(rootView: AppCoordinatorView(coordinator: AppCoordinator()))
        window?.makeKeyAndVisible()
    }

}
