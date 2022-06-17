//
//  SimpleToDoApp.swift
//  SimpleToDo
//
//  Created by Jacek on 17/06/2022.
//

import SwiftUI

@main
struct SimpleToDoApp: App {
    @StateObject private var model = ViewModel()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(model: model)
                SelectSomethingView()
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                model.save()
            }
        }
    }
}
