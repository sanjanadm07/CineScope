import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Hello, CineScope!")
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .foregroundStyle(.white)
                    
                    // search view
                    SearchView()
                    
                    // movie posters cards view
                    
                    // trenading movie cards view
                    
                    // subscrinption ads view
                    
                    // tab bar
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}

// tab bar - home , dowloads , favr, profile
// home - search view, movies poster, trending , subscription ads

