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
                SearchView(searchText: $viewModel.searchText)
                ScrollView {
                    if viewModel.searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                        // popular movie posters cards view
                        MovieCardView(movies: viewModel.popularMovies, heading: "Popular Movies")
                        
                        // trending movie cards view
                        MovieCardView(movies: viewModel.trendingMovies, heading: "Trending Movies")
                        
                        // upcoming movie cards view
                        MovieCardView(movies: viewModel.upcomingMovies, heading: "Upcoming Movies")
                    } else if viewModel.isSearchLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                    } else if viewModel.searchResults.isEmpty {
                        Text("No movies found")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        // searched rsults
                        MovieCardView(movies: viewModel.searchResults, heading: "Search Results")
                    }
                    
                }
                
               
                Spacer()
            }
            
        }
        .task {
            await viewModel.fetchPopularMovies()
            await viewModel.fetchTrendingMovies()
            await viewModel.fetchUpcomingMovies()
        }
        .task(id: viewModel.searchText) {
            let query = viewModel.searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            
            guard !query.isEmpty else {
                viewModel.clearSearchResults()
                return
            }
            do {
                try await Task.sleep(for: .milliseconds(500))
            } catch {
                return
            }
            guard !Task.isCancelled else {
                return
            }
            
            await viewModel.searchMovies(query: query)
        }
    }
    
}

