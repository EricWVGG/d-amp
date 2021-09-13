//
//  DampApp.swift
//  Damp
//
//  Created by Eric Jacobsen on 9/13/21.
//

import SwiftUI

@main
struct DampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
