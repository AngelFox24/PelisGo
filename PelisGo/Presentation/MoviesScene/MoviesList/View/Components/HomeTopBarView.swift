//
//  HomeTopBarView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 24/11/23.
//

import SwiftUI

enum HomeSelection {
    case refresh
    case logOut
    case clearCoreData
    var longDescription: String {
        switch self {
        case .refresh:
            let refreshLabel = NSLocalizedString("Refresh", comment: "Refresh")
            return refreshLabel
        case .logOut:
            let logOutLabel = NSLocalizedString("Log Out", comment: "Log Out")
            return logOutLabel
        case .clearCoreData:
            let cleanLocalDataLabel = NSLocalizedString("Clean Local Data", comment: "Clean Local Data")
            return cleanLocalDataLabel
        }
    }
    static var allValues: [HomeSelection] {
        return [.logOut, .clearCoreData]
    }}

struct HomeTopBarView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var detailViewModel: DetailViewModel
    @EnvironmentObject var navManager: NavManager
    var body: some View {
        HStack {
            Spacer()
            Text("PELIS GO")
                .font(.custom("Artifika-Regular", size: 20))
            Spacer()
            HStack(content: {
                Menu {
                    Button(role: .none, action: {
                        logInViewModel.logOut()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "arrow.up.circle")
                        })
                        HStack(content: {
                            Text(HomeSelection.logOut.longDescription)
                        })
                    })
                    Button(role: .none, action: {
                        homeViewModel.clearAllData()
                        homeViewModel.fetchMovies()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "trash")
                        })
                        HStack(content: {
                            Text(HomeSelection.clearCoreData.longDescription)
                        })
                    })
                    Button(role: .none, action: {
                        homeViewModel.fetchMovies()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "arrow.circlepath")
                        })
                        HStack(content: {
                            Text(HomeSelection.refresh.longDescription)
                        })
                    })
                } label: {
                    CustomButton2()
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 8)
        .padding(.horizontal, 10)
        .background(Color("color_primary"))
    }
}

struct HomeTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dependencies = Dependencies()
        HomeTopBarView()
            .environmentObject(dependencies.logInViewModel)
            .environmentObject(dependencies.homeViewModel)
            .environmentObject(dependencies.detailViewModel)
            .environmentObject(dependencies.navManager)
    }
}
