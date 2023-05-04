import SwiftUI

struct TagPost: View {
    let text: String
    let colorsTags: [String: Color] = ["Наука": Color("Blue2"), "Мастер-класс": Color("Purple"), "Конференция": Color("Blue3"), "Театр": Color("Green"), "Спорт": Color("Yellow"), "Концерт": Color("Brown"), "Тренинг": Color("Red2")]
    
    var body: some View {
        Text(text)
            .customTag(colorBackground: colorsTags[text] ?? Color.clear)
    }
}
