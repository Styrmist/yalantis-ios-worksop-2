import Foundation

enum FeedCoordinatorNavigation: String {

    case feed
    case item

}

final class FeedCoordinator: Coordinator, DeeplinkHandable {

    @Published var navigationStack: [(FeedCoordinatorNavigation, Any)] = []
    
    init(feed: Feed) {
        let viewModel = FeedViewModel(feed: feed)
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .selectItem(let itemId):
                self?.pushItemCoordinator(itemId)
            }
        }

        pushToNavigationStack(.feed, viewModel: viewModel)
    }
    
    private func pushItemCoordinator(_ itemId: ItemId) {
        let coordinator = ItemCoordinator(itemId: itemId)
        coordinator.onFinish = { [weak self] in
            self?.popFromNavigationStack()
        }

        pushToNavigationStack(.item, viewModel: coordinator)
    }

    func handleURL(_ url: URL) -> Bool {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }

        let pathComponents = urlComponents.path.components(separatedBy: "/").dropFirst() // empty

        guard let currentPathComponent = pathComponents.first,
              let coordinator = FeedCoordinatorNavigation(rawValue: currentPathComponent) else { return false }

        switch coordinator {
        case .item:
            let queryItems = urlComponents.queryItems
            if let itemId = queryItems?.first(where: { $0.name == "itemId" })?.value {
                let coordinator = ItemCoordinator(itemId: itemId)
                coordinator.onFinish = { [weak self] in
                    self?.popFromNavigationStack()
                }

                pushToNavigationStack(.item, viewModel: coordinator)

                urlComponents.path = "/".appending(pathComponents.dropFirst().joined(separator: "/"))

                guard let url = urlComponents.url else { return false}

                return coordinator.handleURL(url)
            } else {
                return false
            }

        default:
            return false
        }
    }
    
}
