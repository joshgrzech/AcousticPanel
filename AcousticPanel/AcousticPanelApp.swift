//
//  AcousticPanelApp.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import SwiftData
import SwiftUI
import AppKit


@main
struct AcousticPanelApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        let model = ModuleContainerViewModel()
        WindowGroup {
            ModuleStackView(viewModel: model)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarManager: StatusBarItemManager?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let viewModel = MenuBarViewModel()
        statusBarManager = StatusBarItemManager(viewModel: viewModel)
    }
}

struct AcousticPanelApp_Previews: PreviewProvider {
    static var previews: some View {
        ModuleStackView(viewModel: ModuleContainerViewModel())
    }
}
