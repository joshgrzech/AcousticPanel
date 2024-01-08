//
//  EqualizerModel.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import Foundation

class EqualizerModel {
    var bands: [EQBand]

    init() {
        // Initialize with default values or load saved settings
        bands = [EQBand(frequency: 31, gain: 0),
                 EQBand(frequency: 62, gain: 0),
                 EQBand(frequency: 125, gain: 0),
                 EQBand(frequency: 250, gain: 0),
                 EQBand(frequency: 500, gain: 0),
                 EQBand(frequency: 1000, gain: 0),
                 EQBand(frequency: 2000, gain: 0),
                 EQBand(frequency: 4000, gain: 0),
                 EQBand(frequency: 8000, gain: 0),
                 EQBand(frequency: 16000, gain: 0)]
    }

    struct EQBand {
        let frequency: Float // Frequency in Hz
        var gain: Float // Gain in dB
    }
}
