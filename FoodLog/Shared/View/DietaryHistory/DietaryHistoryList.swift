//

import SwiftUI

struct DietaryHistoryList: View {
    @State private var isShowingFoodList = false
    
    var body: some View {
        NavigationView {
            List {
                Text("Dietary History")
                    .font(.headline)
            }
            .navigationTitle("Dietary History")
            .fullScreenCover(isPresented: $isShowingFoodList) {
                NavigationView {
                    Text("Food List here")
                        .navigationTitle("Food List")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isShowingFoodList = true }, label: { Label("Food Reference", systemImage: "refrigerator") })
                }
            }
        }
    }
}

struct DietaryHistoryList_Previews: PreviewProvider {
    static var previews: some View {
        DietaryHistoryList()
    }
}
