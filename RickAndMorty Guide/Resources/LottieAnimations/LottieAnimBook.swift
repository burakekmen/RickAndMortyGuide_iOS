//
//  LottieAnimBook.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import Lottie

typealias LottieAnimKeys = LottieAnimBook.Anim

protocol LottieAnimable {
    var fileName: String { get }
}

extension LottieAnimable {
    func of() -> String {
        return fileName
    }
}

public struct LottieAnimBook {

    enum Anim: String, LottieAnimable {

        internal var fileName: String {
            return self.rawValue
        }

        case lottie_anim_progress_loading
        case mortyNotFound
        
    }

}

// MARK: AnimationView
extension AnimationView {

    convenience init(nameKey: LottieAnimKeys) {
        self.init(name: nameKey.of())
    }

    convenience init(nameKey: LottieAnimKeys,
                     bundle: Bundle = Bundle.main,
                     imageProvider: AnimationImageProvider? = nil,
                     animationCache: AnimationCacheProvider? = LRUAnimationCache.sharedCache) {
        self.init(name: nameKey.of(), bundle: bundle, imageProvider: imageProvider, animationCache: animationCache)
    }
}
