//
//  SourceWordCounterApp.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/26.
//

import SwiftUI

@main
struct SourceWordCounterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
