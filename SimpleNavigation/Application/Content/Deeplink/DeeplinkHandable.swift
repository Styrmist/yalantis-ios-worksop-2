import Foundation

protocol DeeplinkHandable {

    var handlers: [DeeplinkHandable] { get }

    @discardableResult
    func handleURL(_ url: URL) -> Bool

}
