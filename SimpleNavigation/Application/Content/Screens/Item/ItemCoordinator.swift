import Foundation

enum ItemCoordinatorNavigation: String {

    case item
    case details

}

final class ItemCoordinator: Coordinator, DeeplinkHandable {

    @Published var navigationStack: [(ItemCoordinatorNavigation, Any)] = []
    
    var onFinish: (() -> Void)!
    
    init(itemId: ItemId) {
        let viewModel = ItemViewModel(itemId: itemId)
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .back:
                self?.onFinish()

            case .more:
                self?.pushItemDetails()
            }
        }

        pushToNavigationStack(.item, viewModel: viewModel)
    }
    
    func popItemDetails() {
        popFromNavigationStack()
    }
    
    private func pushItemDetails() {
        let viewModel = ItemDetailsViewModel()
        pushToNavigationStack(.details, viewModel: viewModel)
    }

    func handleURL(_ url: URL) -> Bool {

        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }

        let pathComponents = urlComponents.path.components(separatedBy: "/").dropFirst() // empty

        guard let currentPathComponent = pathComponents.first,
              let coordinator = ItemCoordinatorNavigation(rawValue: currentPathComponent) else { return false }

        switch coordinator {
        case .details:
            pushItemDetails()

            return true

        default:
            return false
        }
    }
    
}
