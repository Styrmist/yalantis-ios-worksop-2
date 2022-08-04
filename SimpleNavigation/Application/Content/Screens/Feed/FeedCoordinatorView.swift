import SwiftUI

struct FeedCoordinatorView: View {
    @ObservedObject var coordinator: FeedCoordinator
    
    var body: some View {
        ZStack {
            FeedView(viewModel: coordinator.viewModel(for: .feed))

            LazyNavigationLink(
                isActive: coordinator.isActive(.item),
                destination: {
                    ItemCoordinatorView(coordinator: coordinator.viewModel(for: .item))
                }
            )
        }
    }
    
}
