import SwiftUI

struct AppCoordinatorView: View {

    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTabItem) {
            NavigationView {
                FeedCoordinatorView(coordinator: coordinator.viewModel(for: .homeFeedCoordinator))
            }
            .tabItem {
                Label("app.tab.feed", systemImage: "house")
            }
            .tag(1)
            .navigationViewStyle(.stack)

            NavigationView {
                FeedCoordinatorView(coordinator: coordinator.viewModel(for: .musicFeedCoordinator))
            }
            .tabItem {
                Label("app.tab.music", systemImage: "music.note.list")
            }
            .tag(2)
            .navigationViewStyle(.stack)

            NavigationView {
                AccountCoordinatorView(coordinator: coordinator.viewModel(for: .accountCoordinator))
            }
            .tabItem {
                Label("app.tab.account", systemImage: "person")
            }
            .tag(3)
            .navigationViewStyle(.stack)
        }
    }
    
}
