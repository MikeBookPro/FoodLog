//import SwiftUI
//
//struct DietaryHistoryList<FoodListView: View>: View {
//  // struct DietaryHistoryList<Editor: EditorViewRepresentable>: View where Editor.Model == FoodConsumptionEvent {
//  @State private var viewModel: Self.ViewModel
//
//  private let foodItemList: () -> FoodListView
//
//  //    private let editorBuilder: (Editor.Model) -> Editor
//  //    init(consumptionEvents: [FoodConsumptionEvent],  @ViewBuilder editorView: @escaping ((Editor.Model) -> Editor)? = nil) {
//  init(consumptionEvents: [FoodConsumptionEvent], @ViewBuilder foodList viewBuilder: @escaping () -> FoodListView) {
//    self.foodItemList = viewBuilder
//    self._viewModel = .init(initialValue: ViewModel(consumptionEvents: consumptionEvents))
//    //        self.editorBuilder = editorView
//  }
//
//  @ViewBuilder
//  private static func navigationView(for event: FoodConsumptionEvent) -> some View {
//    NavigationLink {
//      VStack {
//        LabeledContent("Name") {
//          Text(event.foodItem.name)
//        }
//
//        LabeledContent("Brand name") {
//          Text(event.foodItem.brand?.name ?? "--")
//        }
//
//        LabeledContent("Amount") {
//          Text(event.quantity.measurement, format: .measurementStyle)
//        }
//
//        LabeledContent("Serving size") {
//          Text(event.foodItem.nutritionInfo.servingSize.measurement, format: .measurementStyle)
//        }
//      }
//    } label: {
//      HStack {
//        Text(event.foodItem.name)
//        Spacer()
//        if let brand = event.foodItem.brand?.name {
//          Text(brand)
//        }
//      }
//      .padding(.vertical, 8)
//    }
//  }
//
//  var body: some View {
//    NavigationView {
//      List(selection: $viewModel.selected) {
//        ForEach(viewModel.sectionModels, id: \.name) { section in
//          Section(section.name) {
//            ForEach(section.items, id: \.id) { event in
//              Self.navigationView(for: event)
//            }
//          }
//        }
//      }
//      .navigationTitle("Dietary History")
//      .sheet(isPresented: $viewModel.isShowingFoodList, content: foodItemList)
//      .toolbar {
//        ToolbarItem(placement: .navigationBarLeading) {
//          Button(action: { viewModel.isShowingFoodList = true }, label: {
//            Label("Food Reference", systemImage: "refrigerator")
//          })
//        }
//      }
//    }
//  }
//}
//
//extension DietaryHistoryList {
//  private struct ViewModel {
//    typealias SectionModel = (name: String, items: [FoodConsumptionEvent])
//
//    var selected: FoodConsumptionEvent?
//    var isShowingFoodList = false
//    let sectionModels: [SectionModel]
//
//    init(consumptionEvents: [FoodConsumptionEvent]) {
//      let foodByDate = Dictionary.init(grouping: consumptionEvents, by: \.date.abbreviatedDateString)
//      self.sectionModels = foodByDate.reduce(into: [SectionModel]()) { partialResults, pair in
//        partialResults.append(SectionModel(name: pair.key, items: pair.value))
//      }
//      .sorted { $0.name.abbreviatedDate > $1.name.abbreviatedDate }
//    }
//  }
//}
//
//#if DEBUG
//struct DietaryHistoryList_Previews: PreviewProvider {
//  static let consumptionEvents: [FoodConsumptionEvent] = [
//    PreviewData.consumptionEvents(forFood: PreviewData.Food.cheese, count: 5),
//    PreviewData.consumptionEvents(forFood: PreviewData.Food.egg, count: 5),
//    PreviewData.consumptionEvents(forFood: PreviewData.Food.mayonnaise, count: 5),
//    PreviewData.consumptionEvents(forFood: PreviewData.Food.sardines, count: 5),
//    PreviewData.consumptionEvents(forFood: PreviewData.Food.tuna, count: 5),
//  ].reduce([FoodConsumptionEvent](), +)
//
//  let consumptionEvents: [(section: String, items: [FoodConsumptionEvent])]
//
//  var dict = Dictionary(grouping: consumptionEvents, by: \.date)
//
//  static var previews: some View {
//    DietaryHistoryList(consumptionEvents: consumptionEvents) {
//      FoodReferenceList(
//        list: PreviewData.foodItems,
//        editorView: FoodItemForm.init(_:)
//      )
//    }
//  }
//}
//#endif
