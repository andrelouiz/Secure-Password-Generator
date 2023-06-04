//
//  Password_GeneratorApp.swift
//  Password Generator
//
//  Created by Andre on 04/06/2023.
//

import SwiftUI
import Foundation

class PasswordGenerator {
    private static let uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let lowercaseChars = "abcdefghijklmnopqrstuvwxyz"
    private static let numericChars = "0123456789"
    private static let symbolChars = "!@#$%^&*()"

    func generatePassword(length: Int, includeUppercase: Bool, includeLowercase: Bool, includeNumeric: Bool, includeSymbols: Bool) -> String {
        var charPool = ""
        var generatedPassword = ""

        if includeUppercase {
            charPool += PasswordGenerator.uppercaseChars
        }
        if includeLowercase {
            charPool += PasswordGenerator.lowercaseChars
        }
        if includeNumeric {
            charPool += PasswordGenerator.numericChars
        }
        if includeSymbols {
            charPool += PasswordGenerator.symbolChars
        }

        let charPoolLength = charPool.count

        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<charPoolLength)
            let randomCharacter = charPool[charPool.index(charPool.startIndex, offsetBy: randomIndex)]
            generatedPassword.append(randomCharacter)
        }

        return generatedPassword
    }

    func copyToClipboard(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }

}

extension Color {
    static let navyBlue = Color(red: 0.0, green: 0.0, blue: 0.5)
}

let backgroundGradient = LinearGradient(
    colors: [Color.orange, Color.navyBlue],
    startPoint: .top, endPoint: .bottom)


struct ContentView: View {
    @State private var passwordLength = 11
    @State private var includeUppercase = true
    @State private var includeLowercase = true
    @State private var includeNumeric = true
    @State private var includeSymbols = false
    @State private var generatedPassword = ""

    var passwordGenerator = PasswordGenerator()

    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
                
                Text("Secure Password Generator ")
                    .font(.system(size: 25, weight: .heavy, design: .default))
                    .padding()
                    .foregroundColor(.white)
                
                HStack {
                    Text("Password Length:")
                        .padding()
                    Stepper(value: $passwordLength, in: 4...32) {
                        Text("\(passwordLength)")
                    }
                    .padding()
                }
                
                
                Toggle("Include Uppercase", isOn: $includeUppercase)
                    .padding()
                Toggle("Include Lowercase", isOn: $includeLowercase)
                    .padding()
                Toggle("Include Numeric", isOn: $includeNumeric)
                    .padding()
                Toggle("Include Symbols", isOn: $includeSymbols)
                    .padding()
                
                Button(action: generatePassword) {
                    Text("Generate Password")
                        .font(.title2)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Text("Generated Password:")
                    .font(.title2)
                    .foregroundColor(.orange)
                    .padding()
                
                Text(generatedPassword)
                    .font(.title)
                    .padding()
                
                Button(action: copyPassword) {
                    Text("Copy Password")
                        .font(.title2)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }

    func generatePassword() {
        generatedPassword = passwordGenerator.generatePassword(length: passwordLength, includeUppercase: includeUppercase, includeLowercase: includeLowercase, includeNumeric: includeNumeric, includeSymbols: includeSymbols)
    }

    func copyPassword() {
        passwordGenerator.copyToClipboard(text: generatedPassword)
    }
}
