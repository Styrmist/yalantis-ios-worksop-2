import Foundation

protocol DeeplinkHandable {

    @discardableResult
    func handleURL(_ url: URL) -> Bool

}
