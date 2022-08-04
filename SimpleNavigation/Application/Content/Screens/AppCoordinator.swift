import Foundation
import SwiftUI

enum AppCoordinatorNavigation: String {

    case homeFeedCoordinator = "home"
    case musicFeedCoordinator = "music"
    case accountCoordinator = "account"

}

final class AppCoordinator: Coordinator, DeeplinkHandable {

    private let handlers: [AppCoordinatorNavigation: DeeplinkHandable]

    @Published var navigationStack: [(AppCoordinatorNavigation, Any)] = []
    @Published var selectedTabItem: Int = 0
    
    init() {
        let homeFeedCoordinator = FeedCoordinator(feed: .home)
        let musicFeedCoordinator = FeedCoordinator(feed: .music)
        let accountCoordinator = AccountCoordinator()

        handlers = [
            .homeFeedCoordinator: homeFeedCoordinator,
            .musicFeedCoordinator: musicFeedCoordinator,
            .accountCoordinator: accountCoordinator
        ]

        handlers.forEach {
            pushToNavigationStack($0.key, viewModel: $0.value)
        }
    }

    func handleURL(_ url: URL) -> Bool {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: false)?.host,
              let navigation = AppCoordinatorNavigation(rawValue: host),
              let coordinator = handlers[navigation] else { return false }

        switch navigation {
        case .homeFeedCoordinator:
            selectedTabItem = 1

        case .musicFeedCoordinator:
            selectedTabItem = 2

        case .accountCoordinator:
            selectedTabItem = 3
        }

        return coordinator.handleURL(url)
    }

}
