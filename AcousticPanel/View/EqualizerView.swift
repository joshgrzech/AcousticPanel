//
//  EqualizerView.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import SwiftUI

struct EqualizerView: View {
    @ObservedObject var viewModel: EqualizerViewModel

    var body: some View {
        HStack {
            ForEach(viewModel.equalizerModel.bands.indices, id: \.self) { index in
                VStack {
                    Text(formatFrequency(viewModel.equalizerModel.bands[index].frequency))
                        .font(.caption)
                    Slider(value: Binding(
                        get: { viewModel.equalizerModel.bands[index].gain },
                        set: { newValue in
                            viewModel.equalizerModel.bands[index].gain = newValue
                            viewModel.updateEqualizerBands()
                        }),
                    in: -24 ... 24)
                        .rotationEffect(.degrees(-90))
                }
            }
        }
        .padding()
    }

    private func formatFrequency(_ frequency: Float) -> String {
        if frequency >= 1000 {
            return String(format: "%.1fK", frequency / 1000)
        } else {
            return "\(Int(frequency))Hz"
        }
    }
}

struct EqualizerView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EqualizerModel()
        let viewModel = EqualizerViewModel(model: model)
        EqualizerView(viewModel: viewModel)
    }
}
