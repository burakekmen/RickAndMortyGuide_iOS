//
//  DataHelper.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import UIKit

struct DataHelper {

    static let shared = DataHelper()

    private init() { }
    
    let CONSTANT_PHONE_NUMBER_MASK_TR = "(###) ### ## ##"

    func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}

