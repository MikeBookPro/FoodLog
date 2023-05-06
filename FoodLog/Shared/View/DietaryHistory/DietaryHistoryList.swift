//

import SwiftUI

struct DietaryHistoryList: View {
    @State private var isShowingFoodList = false
    
    let consumptionEvents: [FoodConsumptionEvent]
    
    var body: some View {
        List() {
            ForEach(consumptionEvents, id: \.id) { event in
                HStack {
                    Text(event.foodItem.name)
                    Spacer()
                    if let brand = event.foodItem.brand?.name {
                        Text(brand)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        
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

#if DEBUG
struct DietaryHistoryList_Previews: PreviewProvider {
    static let consumptionEvents: [FoodConsumptionEvent] = [
        PreviewData.consumptionEvents(forFood: PreviewData.Food.cheese, count: 5),
        PreviewData.consumptionEvents(forFood: PreviewData.Food.egg, count: 5),
        PreviewData.consumptionEvents(forFood: PreviewData.Food.mayonnaise, count: 5),
        PreviewData.consumptionEvents(forFood: PreviewData.Food.sardines, count: 5),
        PreviewData.consumptionEvents(forFood: PreviewData.Food.tuna, count: 5)
    ].reduce([FoodConsumptionEvent](), +)
    
    static var previews: some View {
        DietaryHistoryList(consumptionEvents: consumptionEvents)
    }
}
#endif
