import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var coordinator: DeeplinkHandable? //

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        window = (scene as? UIWindowScene).map(UIWindow.init(windowScene:))
        let coordinator = AppCoordinator()
        window?.rootViewController = UIHostingController(rootView: AppCoordinatorView(coordinator: coordinator))
        window?.makeKeyAndVisible()

        self.coordinator = coordinator
    }

//    xcrun simctl openurl booted "deeplink://itworks"
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let firstUrl = URLContexts.first?.url else {
            return
        }

        print(firstUrl.absoluteString)
        coordinator?.handleURL(firstUrl)
    }

}
