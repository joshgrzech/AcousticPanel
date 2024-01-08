//
//  ModuleStackView.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import SwiftUI

struct ModuleStackView: View {
    @ObservedObject var viewModel: ModuleContainerViewModel
    @GestureState private var dragState = DragState.inactive
    @State private var isButtonPressed = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.modules.indices, id: \.self) { index in
                        ModuleView(content: {
                            if let equalizerVM = viewModel.modules[index] as? EqualizerViewModel {
                                EqualizerView(viewModel: equalizerVM)
                            } else {
                                EmptyView()
                            }
                        }, isDragging: viewModel.currentlyDraggingIndex == index)
                            .offset(y: viewModel.currentlyDraggingIndex == index ? dragState.translation.height : 0)
                            .gesture(dragGesture(for: index))
                            .animation(.default, value: dragState.translation)
                    }
                }
                .padding()
            }
            Spacer()

            addButton
                .padding(.horizontal)
                .padding(.bottom)
                .scaleEffect(isButtonPressed ? 0.85 : 1)

                .onLongPressGesture(
                    minimumDuration: .infinity,
                    pressing: { isPressing in
                        withAnimation(.spring()) {
                            isButtonPressed = isPressing
                        }
                    },
                    perform: {}
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isButtonPressed)
        }
    }

    private var addButton: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 20, height: 20)
            .padding()
            .foregroundColor(.white)
            .cornerRadius(100)

            .background(Color.blue)
            .cornerRadius(100)
            .shadow(radius: 10)
    }

    private func dragGesture(for index: Int) -> some Gesture {
        DragGesture()
            .updating($dragState) { drag, state, _ in
                state = .dragging(translation: drag.translation)
            }
            .onChanged { drag in
                if viewModel.currentlyDraggingIndex == nil {
                    viewModel.startDragging(moduleIndex: index, startPosition: drag.startLocation)
                }
            }
            .onEnded { _ in
                viewModel.dropModule(withTranslation: dragState.translation)
            }
    }
}

struct DropViewDelegate: DropDelegate {
    let index: Int
    var viewModel: ModuleContainerViewModel

    func performDrop(info: DropInfo) -> Bool {
        viewModel.handleDrop(at: index)
        return true
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

struct ModuleStackView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleStackView(viewModel: ModuleContainerViewModel())
    }
}
