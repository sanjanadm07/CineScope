import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @EnvironmentObject private var coordinator: AppCoordinator
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
                HStack {
                    Text("Hello, CineScope!")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        isLoggedIn = false
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            
                            Text("Logout")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.red.opacity(0.8))
                        .clipShape(Capsule())
                    }
                }
                .padding()
                
                // search view
                SearchView(searchText: $viewModel.searchText)
                // movies display section
                MovieDisplay()
                
                
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

extension HomeView {
    func MovieDisplay() -> some View {
        ScrollView {
            if viewModel.searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                // popular movie posters cards view
                MovieCardView(movies: viewModel.popularMovies, heading: "Popular Movies", isLoadingMore: viewModel.isLoadingMorePage, paginationError: viewModel.paginationError, onLastMovieAppeared: {
                    Task {
                        await viewModel.loadNextPopularPage()
                    }}, onRetry: {
                        Task {
                            await viewModel.loadNextPopularPage()
                        }
                    }, onMovieSelected: { movie in
                        coordinator.showMovieDetail(movie: movie)
                    })
                
                // trending movie cards view
                MovieCardView(movies: viewModel.trendingMovies, heading: "Trending Movies", onMovieSelected: { movie in
                    coordinator.showMovieDetail(movie: movie)
                })
                
                // upcoming movie cards view
                MovieCardView(movies: viewModel.upcomingMovies, heading: "Upcoming Movies", onMovieSelected: { movie in
                    coordinator.showMovieDetail(movie: movie)
                })
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
                MovieCardView(movies: viewModel.searchResults, heading: "Search Results", onMovieSelected: { movie in
                    coordinator.showMovieDetail(movie: movie)
                })
            }
        }
    }
    
}

