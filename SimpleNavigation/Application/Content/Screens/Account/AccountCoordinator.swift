import Foundation

enum AccountCoordinatorNavigation: String {

    case account
    case accountEdit = "edit"
    case accountConfirm = "confirm"
    case itemCoordinator = "item"

}

final class AccountCoordinator: Coordinator, DeeplinkHandable {

    @Published var navigationStack: [(AccountCoordinatorNavigation, Any)] = []
    
    init() {
        let viewModel = AccountViewModel()
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .selectItem(let itemId):
                self?.pushItemCoordinator(itemId)

            case .edit:
                self?.pushAccountEditView()
            }
        }

        pushToNavigationStack(.account, viewModel: viewModel)
    }
    
    private func pushAccountEditView() {
        let viewModel = AccountEditViewModel()
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .cancel:
                self?.popFromNavigationStack()

            case let .confirm(name, username):
                self?.pushAccountConfirmView(name: name, username: username)
            }
        }

        pushToNavigationStack(.accountEdit, viewModel: viewModel)
    }
    
    private func pushAccountConfirmView(name: String, username: String) {
        let viewModel = AccountConfirmViewModel(name: name, username: username)
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .back:
                self?.popFromNavigationStack()

            case .complete:
                self?.popFromNavigationStack()
                self?.popFromNavigationStack()
            }
        }

        pushToNavigationStack(.accountConfirm, viewModel: viewModel)
    }
    
    private func pushItemCoordinator(_ itemId: ItemId) {
        let coordinator = ItemCoordinator(itemId: itemId)
        coordinator.onFinish = { [weak self] in
            self?.popFromNavigationStack()
        }

        pushToNavigationStack(.itemCoordinator, viewModel: coordinator)
    }

    func handleURL(_ url: URL) -> Bool {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }

        let pathComponents = urlComponents.path.components(separatedBy: "/")

        guard let currentPathComponent = pathComponents.last,
              let coordinator = AccountCoordinatorNavigation(rawValue: currentPathComponent) else { return false }

        switch coordinator {
        case .accountEdit:
            pushAccountEditView()

            return true

        case .itemCoordinator:
            let queryItems = urlComponents.queryItems
            if let itemId = queryItems?.first(where: { $0.name == "itemId" })?.value {
                pushItemCoordinator(itemId)

                return true
            } else {
                return false
            }

        default:
            return false
        }
    }
    
}
