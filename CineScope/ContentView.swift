import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    var body: some View {
        ZStack {
            if isActive {
                if isLoggedIn {
                    HomeView()
                } else {
                    LoginView(authRepo: AuthRepositoryImpl(authService: MockAuthServices()))
                }
            } else {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image(systemName: "movieclapper.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 100))
                        .padding()
                        
                    Text("CineScope")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Your destination for epic movie experiences")
                        .font(.title3)
                        .foregroundColor(.white)
                    ProgressView()
                        .tint(.white)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.isActive = true
                                }
                            }
                        }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
