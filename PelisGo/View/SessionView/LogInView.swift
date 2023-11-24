//
//  LogInView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 24/11/23.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    var body: some View {
        ZStack {
        Color("color_primary")
            .ignoresSafeArea()
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                Text("Iniciar Sesión")
                    .font(.custom("Artifika-Regular", size: 30))
                    .padding(.bottom, 50)
                VStack(spacing: 40){
                    VStack {
                        CustomTextField(title: "Usuario" ,value: $logInViewModel.logInFields.user, edited: $logInViewModel.logInFields.userEdited, keyboardType: .default)
                        if logInViewModel.logInFields.userError != "" {
                            ErrorMessageText(message: logInViewModel.logInFields.userError)
                            //.padding(.top, 18)
                        }
                    }
                    VStack {
                        CustomTextField(title: "Contraseña" ,value: $logInViewModel.logInFields.password, edited: $logInViewModel.logInFields.passwordEdited, keyboardType: .default, secureField: true)
                        if logInViewModel.logInFields.passwordError != "" {
                            ErrorMessageText(message: logInViewModel.logInFields.passwordError)
                            //.padding(.top, 18)
                        }
                    }
                }
                .padding(.horizontal, 30)
                VStack(spacing: 30) {
                    Button(action: {
                        logInViewModel.logIn()
                    }, label: {
                        VStack {
                            CustomButton1(text: "Ingresar", backgroudColor: Color("color_accent"), minWidthC: 250)
                                .foregroundColor(Color(.black))
                            if logInViewModel.logInFields.errorLogIn != "" {
                                ErrorMessageText(message: logInViewModel.logInFields.errorLogIn)
                                //.padding(.top, 18)
                            }
                        }
                    })
                }
                .padding(.top, 30)
                Spacer()
            }
        }
        .padding(.top, 1) //Resuelve el problema del desvanecimiento en el navigation back button
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    }
}

struct CustomButton1: View {
    let text: String
    var backgroudColor: Color = Color("color_accent")
    var minWidthC: CGFloat = 200
    var body: some View {
        Text(text)
            .font(.custom("Artifika-Regular", size: 20))
            .frame(minWidth: minWidthC)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(backgroudColor)
            .cornerRadius(15.0)
    }
}

struct ErrorMessageText: View {
    let message: String
    var body: some View {
        Text(message)
            .foregroundColor(.red)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        
        let localMovieManager = LocalMovieManager(mainContext: PersistenceController.shared.viewContext)
        let remoteMovieManager = RemoteMovieManager()
        //Repositories
        let movieRepository = MovieRepositoryImpl(localManager: localMovieManager, remoteManager: remoteMovieManager)
        //ViewModel
        let logInViewModel = LogInViewModel()
        let homeViewModel = HomeViewModel(movieRepository: movieRepository)
        let detailViewModel = DetailViewModel(movieRepository: movieRepository)
        let navManager = NavManager()
        LogInView()
            .environmentObject(logInViewModel)
            .environmentObject(homeViewModel)
            .environmentObject(detailViewModel)
            .environmentObject(navManager)
    }
}
