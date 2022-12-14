//
//  NSError+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension NSError {

    /// A convenience initializer for NSError to set its description.
    ///
    /// - Parameters:
    ///   - domain: The error domain.
    ///   - code: The error code.
    ///   - description: Some description for this error.
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [(kCFErrorLocalizedDescriptionKey as CFString) as String: description])
    }

}

/** How to use
 let myError = NSError(
  domain: "SomeDomain",
  code: 123,
  description: "Some description."
)
 */

