//
//  SwiftendApp.swift
//  Swiftend
//
//  Created by Ayodeji Osasona on 08/06/2023.
//

import SwiftUI

@main
struct SwiftendApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
