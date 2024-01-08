//
//  StatusBarManager.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import Foundation
import SwiftUI

class StatusBarItemManager {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var viewModel: MenuBarViewModel

    init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
        setupStatusBar()
    }

    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "MyApp"
        
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 200, height: 200)
        popover?.behavior = .transient
        popover?.contentViewController = NSHostingController(rootView: MenuContentView(viewModel: viewModel))

        statusItem?.button?.action = #selector(togglePopover(_:))
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem?.button {
            if popover?.isShown == true {
                popover?.performClose(sender)
            } else {
                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
