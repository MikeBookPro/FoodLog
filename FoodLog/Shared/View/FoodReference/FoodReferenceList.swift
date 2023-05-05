import SwiftUI

struct FoodReferenceList: View {
    @State private var isShowingEditor = false
    
    var body: some View {
        NavigationView {
            List {
                Text("Food Reference")
                    .font(.headline)
            }
            .navigationTitle("Food Reference")
//            .fullScreenCover(isPresented: $isShowingFoodList) {
//                NavigationView {
//                    Text("Food List here")
//                        .navigationTitle("Food List")
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingEditor = true }, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
}

#if DEBUG
struct FoodReferenceList_Previews: PreviewProvider {
    static var previews: some View {
        FoodReferenceList()
    }
}
#endif
