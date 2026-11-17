import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init() {
        do {
            let appConfig = try AppConfiguration()
            let apiConfig = APIConfiguration(appConfiguration: appConfig)
            let apiClient = APIClient(apiConfig: apiConfig)
            let movieService = MovieService(apiClient: apiClient)
            
            _viewModel = StateObject(wrappedValue: HomeViewModel(movieService: movieService))
        } catch {
            fatalError("Failed to initiliaze app congiration: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Hello, CineScope!")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .foregroundStyle(.white)
                
                // search view
                //                    SearchView()
                
                // popular movie posters cards view
                MovieCardView(movie: viewModel.movies, heading: "Popular")
                // trenading movie cards view
                
                // tab bar
                Spacer()
            }
            
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
    
}

