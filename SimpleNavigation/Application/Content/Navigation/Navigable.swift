import Foundation

protocol Navigable {

    associatedtype NavigationItem: Equatable
    
    var onNavigation: ((NavigationItem) -> Void)! { get }
    
}
