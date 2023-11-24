//
//  CustomTopBarView.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import SwiftUI

struct CustomTopBarView: View {
    @EnvironmentObject var navManager: NavManager
    var tittle: String = "None"
    var body: some View {
        HStack {
            HStack(content: {
                Button(action: {
                    navManager.goToBack()
                }, label: {
                    CustomButton3()
                })
                Spacer()
                Button(action: {
                    /*
                    if ventasCoreDataViewModel.registerSale(cart: carritoCoreDataViewModel.cartCoreData, customer: carritoCoreDataViewModel.customerInCar) {
                        carritoCoreDataViewModel.fetchCart()
                        productsCoreDataViewModel.fetchProducts()
                        playSound(named: "Success1")
                    }
                     */
                }, label: {
                    Text(tittle)
                })
                Spacer()
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 8)
        .padding(.horizontal, 10)
        .background(Color("color_primary"))
    }
}
struct CustomButton3: View {
    var simbol: String = "chevron.backward"
    var body: some View {
        Image(systemName: simbol)
            .font(.custom("Artifika-Regular", size: 22))
            .foregroundColor(Color("color_accent"))
            .frame(width: 40, height: 40)
            .background(.white)
            .cornerRadius(15)
    }
}
#Preview {
    CustomTopBarView()
}
