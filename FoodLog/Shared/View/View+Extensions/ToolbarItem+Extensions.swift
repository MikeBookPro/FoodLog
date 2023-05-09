import SwiftUI

extension ToolbarItem where Content == Button<Label<Text, Image>>, ID == String {
    static func cancel(id: ID, placement: ToolbarItemPlacement = .navigationBarLeading, action: @escaping () -> Void) -> ToolbarItem<ID, Content> {
        ToolbarItem(id: id, placement: placement) {
            Button(role: .cancel, action: action) {
                Label("Cancel", systemImage: "xmark")
//                    .foregroundStyle(Color.red) as! Label<Text, Image>
            }
        }
    }
    
    static func save(id: ID, placement: ToolbarItemPlacement = .navigationBarTrailing, action: @escaping () -> Void) -> ToolbarItem<ID, Content> {
        ToolbarItem(id: id, placement: placement) {
            Button(role: .destructive, action: action) {
                Label("Save", systemImage: "checkmark")
            }
        }
    }
}
