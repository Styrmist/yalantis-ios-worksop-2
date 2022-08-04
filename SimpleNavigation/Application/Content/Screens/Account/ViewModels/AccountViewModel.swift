import Combine

enum AccountNavigation: Equatable {

    case selectItem(ItemId)
    case edit

}

final class AccountViewModel: ObservableObject, Navigable {

    let name: String = "Name"
    let username: String = "@name"

    var onNavigation: ((AccountNavigation) -> Void)!
    
    func selectItem(_ itemId: ItemId) {
        onNavigation(.selectItem(itemId))
    }
    
    func edit() {
        onNavigation(.edit)
    }
    
}
