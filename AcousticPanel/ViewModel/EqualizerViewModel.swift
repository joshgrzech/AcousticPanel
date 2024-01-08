//
//  EqualizerViewModel.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import AVFoundation
import Foundation

class EqualizerViewModel: ObservableObject, AudioModule {
    @Published var equalizerModel: EqualizerModel
    var title: String = "Equalizer"
    private var audioEngine: AVAudioEngine
    private var equalizer: AVAudioUnitEQ

    init(model: EqualizerModel) {
        self.equalizerModel = model
        self.audioEngine = AVAudioEngine()
        self.equalizer = AVAudioUnitEQ(numberOfBands: model.bands.count)

        setupAudioEngine()
        updateEqualizerBands()
    }

    private func setupAudioEngine() {
        // Configure the audio engine and attach the equalizer
        let inputNode = audioEngine.inputNode
        audioEngine.attach(equalizer)
        audioEngine.connect(inputNode, to: equalizer, format: nil)
        audioEngine.connect(equalizer, to: audioEngine.outputNode, format: nil)

        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

    func updateEqualizerBands() {
        // Update equalizer bands based on the model
        for (index, band) in equalizerModel.bands.enumerated() {
            equalizer.bands[index].frequency = band.frequency
            equalizer.bands[index].gain = band.gain
            equalizer.bands[index].bypass = false
        }
    }

    // Add more functions to manipulate the equalizer settings as needed
}
