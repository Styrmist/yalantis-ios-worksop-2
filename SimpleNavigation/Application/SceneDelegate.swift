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

//    xcrun simctl openurl booted "deeplink://itworks"
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let firstUrl = URLContexts.first?.url else {
            return
        }

        print(firstUrl.absoluteString)
    }

}
