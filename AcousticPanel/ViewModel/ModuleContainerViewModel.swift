//
//  ModuleContainerViewModel.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import Foundation
import SwiftUI

class ModuleContainerViewModel: ObservableObject {
    @Published var modules: [AudioModule] = []
    @Published var currentlyDraggingIndex: Int?
    var dragStartPosition: CGPoint?

       
    init() {
        let eqModel = EqualizerModel()
        let module = EqualizerViewModel(model: eqModel)
        modules.append(module)
    }
    
    func startDragging(moduleIndex: Int, startPosition: CGPoint) {
        currentlyDraggingIndex = moduleIndex
        dragStartPosition = startPosition
    }

    func dropModule(withTranslation translation: CGSize) {
            guard let startIndex = currentlyDraggingIndex else { return }

            let estimatedModuleHeight = 50 // An estimated height of a module view
            let dropIndex = max(0, min(modules.count - 1, Int(translation.height / CGFloat(estimatedModuleHeight))))

            if startIndex != dropIndex {
                withAnimation {
                    let movedModule = modules.remove(at: startIndex)
                    modules.insert(movedModule, at: dropIndex)
                }
            }

            currentlyDraggingIndex = nil
            dragStartPosition = nil
        }


    
    func handleDrop(at destinationIndex: Int) {
        guard let sourceIndex = currentlyDraggingIndex else { return }
        guard destinationIndex != sourceIndex else { return }

        withAnimation {
            let movedModule = modules.remove(at: sourceIndex)
            modules.insert(movedModule, at: destinationIndex)
        }
        // Reset the dragged module index
        currentlyDraggingIndex = nil
    }

    func addModule(_ module: AudioModule) {
        modules.append(module)
    }

    func moveModule(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let movedModule = modules.remove(at: sourceIndex)
        modules.insert(movedModule, at: destinationIndex)
    }

    // Methods to reorder, remove, etc.
}
