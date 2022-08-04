import SwiftUI

struct ItemDetailsView: View {
    
    @ObservedObject var viewModel: ItemDetailsViewModel
    
    var body: some View {
        Text(viewModel.details)
    }

}
