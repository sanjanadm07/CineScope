//
//  LoginView.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private  var vm: LoginViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoggingIn: Bool = false
    
    init(authRepo: AuthRepository) {
        _vm = StateObject(wrappedValue: LoginViewModel(authRepo: authRepo))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    // Email Field
                    TextField("Email address", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                    
                    // Password Field with Toggle
                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    //
                    //                if let error = vm.errorMessage {
                    //                    Text(error)
                    //                        .font(.caption)
                    //                        .foregroundColor(.red)
                    //                }
                    switch vm.authState {
                        
                    case .loggedOut:
                        EmptyView()
                        
                    case .loading:
                        ProgressView()
                        
                    case .authenticated(let user):
                        Text("Welcome, \(user.name)!")
                        
                    case .failed(let message):
                        Text(message)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    Spacer()
                    // Sign In Button
                    Button(action: {
                        vm.email = email
                        vm.password = password
                        Task {
                            await vm.login()
                        }
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.blue))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                        
                    }
                    .padding(.top, 10)
                    
                    
                }
                .padding()
                
            }
        }
    }
}

#Preview {
    LoginView(authRepo: AuthRepositoryImpl(authService: MockAuthServices()))
}
