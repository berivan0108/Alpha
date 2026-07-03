//
//  AlphaToDoAppApp.swift
//  AlphaToDoApp
//
//  Created by beri on 6.05.2026.
//
 import FirebaseCore
import SwiftUI

@main
struct AlphaToDoAppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
          MainView()
        }
    }
}
