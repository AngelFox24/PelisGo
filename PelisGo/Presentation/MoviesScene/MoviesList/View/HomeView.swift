//
//  MoviesListView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var detailViewModel: DetailViewModel
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        VStack(spacing: 0) {
            HomeTopBarView()
            if homeViewModel.moviesList.count == 0 {
                VStack {
                    Button(action: {
                        homeViewModel.fetchMovies()
                    }, label: {
                        let refreshLabel = NSLocalizedString("Refresh", comment: "Refresh")
                        VStack(content: {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.custom("Artifika-Regular", size: 90))
                                .foregroundColor(.blue)
                            Text(refreshLabel)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 20)
                                .font(.custom("Artifika-Regular", size: 18))
                        })
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack(content: {
                    List {
                        ForEach(homeViewModel.moviesList) { movie in
                            Button(action: {
                                detailViewModel.saveCurrentMovie(movie: movie)
                                navManager.goToMovieDetail()
                            }, label: {
                                HStack(content: {
                                    MovieCardView(movie: movie, save: false)
                                    VStack(alignment:.leading) {
                                        Spacer()
                                        Text(movie.title)
                                            .foregroundColor(.black)
                                            .font(.custom("Artifika-Regular", size: 20))
                                            .font(.headline)
                                        Spacer()
                                        HStack {
                                            VoteView(voteAverage: movie.vote_average)
                                            Spacer()
                                            Image(systemName: "calendar")
                                            Text(String(movie.release_date_converted?.getDateComponent(dateComponent: .year) ?? 0))
                                        }
                                        .foregroundColor(.yellow)
                                        .font(.custom("Artifika-Regular", size: 20))
                                        Spacer()
                                    }
                                })
                                .border(Color.red)
                                .onAppear(perform: {
                                    if homeViewModel.shouldLoadData(movie: movie) {
                                        homeViewModel.fetchNextPage()
                                    }
                                })
                            })
                            .listRowSeparator(.hidden)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                })
                .navigationDestination(for: NavPathsEnum.self, destination: { view in
                    if view == .movieDetail {
                        withAnimation {
                            MovieDetailView()
                        }
                    }
                })
            }
        }
        .background(Color(.gray))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dependencies = Dependencies()
        HomeView()
            .environmentObject(dependencies.logInViewModel)
            .environmentObject(dependencies.homeViewModel)
            .environmentObject(dependencies.detailViewModel)
            .environmentObject(dependencies.navManager)
    }
}

struct VoteView: View {
    var voteAverage: Float
    var body: some View {
        HStack(content: {
            Image(systemName: "hand.thumbsup.fill")
            Text(String(format: "%.1f", voteAverage))
        })
    }
}
