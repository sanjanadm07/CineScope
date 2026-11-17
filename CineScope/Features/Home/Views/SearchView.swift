import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading)
            TextField("Search", text: $searchText)
                .foregroundStyle(.white)
        }
        .frame(height: 50)
        .background(Color.gray)
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
