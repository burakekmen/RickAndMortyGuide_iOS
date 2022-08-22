//
//  UIDevice+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit
import AudioToolbox

extension UIDevice {

    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}

