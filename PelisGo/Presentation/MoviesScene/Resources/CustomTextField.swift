//
//  CustomTextField.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 24/11/23.
//

import SwiftUI

struct CustomTextField: View {
    var title: String = "Campo"
    @Binding var value: String
    @Binding var edited: Bool
    @FocusState var isTextFieldFocused
    var disable: Bool = false
    var onSubmit: (() -> Void)?
    var keyboardType: UIKeyboardType = .default
    var disableAutocorrection: Bool = true
    var secureField: Bool = false
    var body: some View {
        HStack {
            ZStack {
                    HStack(spacing: 0) {
                        if secureField {
                            SecureField("", text: $value)
                                .focused($isTextFieldFocused)
                                .foregroundColor(.black)
                                .font(.custom("Artifika-Regular", size: 20))
                                .multilineTextAlignment(.center)
                                .keyboardType(keyboardType)
                                .padding(.all, 5)
                                .foregroundColor(.black)
                                .padding(.vertical, 4)
                                .disableAutocorrection(disableAutocorrection)
                                .onTapGesture {
                                    isTextFieldFocused = true
                                }
                                .onChange(of: value, perform: {text in
                                    if text != "" {
                                        edited = true
                                    }
                                })
                                .onSubmit({
                                    if value != "" {
                                        onSubmit?()
                                    }
                                })
                                .disabled(disable)
                        } else {
                            TextField("", text: $value)
                                .focused($isTextFieldFocused)
                                .foregroundColor(.black)
                                .font(.custom("Artifika-Regular", size: 20))
                                .multilineTextAlignment(.center)
                                .keyboardType(keyboardType)
                                .padding(.all, 5)
                                .foregroundColor(.black)
                                .padding(.vertical, 4)
                                .disableAutocorrection(disableAutocorrection)
                                .onTapGesture {
                                    isTextFieldFocused = true
                                }
                                .onChange(of: value, perform: {text in
                                    if text != "" {
                                        edited = true
                                    }
                                })
                                .onSubmit({
                                    if value != "" {
                                        onSubmit?()
                                    }
                                })
                                .disabled(disable)
                        }
                        if isTextFieldFocused {
                            Button(action: {
                                if isTextFieldFocused {
                                    value.removeAll()
                                } else if !disable {
                                    isTextFieldFocused = true
                                }
                            }, label: {
                                Image(systemName: "x.circle")
                                    .foregroundColor(Color("color_accent"))
                                    .font(.custom("Artifika-Regular", size: 16))
                                    .padding(.horizontal, 2)
                                    .padding(.vertical, 8)
                                    .animation(.easeInOut(duration: 0.4), value: isTextFieldFocused)
                            })
                        }
                    }
                    .background(disable ? Color(hue: 1.0, saturation: 0.0, brightness: 0.884) : .white)
                    .cornerRadius(8)
                    Text(title)
                        .font(.custom("Artifika-Regular", size: 14))
                        .padding(.horizontal, 8)
                        .foregroundColor(.black)
                        .background(disable ? Color(hue: 1.0, saturation: 0.0, brightness: 0.884) : .white)
                        .cornerRadius(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: -22)
                        .onTapGesture {
                            if !disable {
                                isTextFieldFocused = true
                            }
                        }
                        .disabled(disable)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var dato: String = "Prueba"
        HStack(spacing: 6) {
            CustomTextField(title: "Nombre del producto",value: $dato ,edited: .constant(false), keyboardType: .numberPad)
            CustomTextField(value: $dato, edited: .constant(false), disable: false, keyboardType: .numberPad)
        }
        .background(Color("color_background"))
    }
}
