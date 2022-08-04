import Foundation

enum FeedCoordinatorNavigation {

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
        false
    }
    
}
