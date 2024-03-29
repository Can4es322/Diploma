import SwiftUI

struct TagEvent: View {
    let text: String
    @State var active = false
    @Binding var activeTags: [String]
    
    let colorsTags: [String: Color] = ["Наука": Color("Blue2"), "Мастер-класс": Color("Purple"), "Конференция": Color("Blue3"), "Театр": Color("Green"), "Спорт": Color("Yellow"), "Концерт": Color("Brown"), "Тренинг": Color("Red2")]
    
    var body: some View {
        Button {
            active.toggle()
            if active {
                activeTags.append(text)
            } else {
                activeTags = activeTags.filter {
                    $0 != text
                }
            }
        } label: {
            Text(text)
                .customTag(colorBackground: active ? colorsTags[text]! : Color("Gray1"))
        }
    }
}
