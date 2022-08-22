//
//  DebugUtils.swift
//  RickAndMortyGuide
//
//

import Foundation
import os.log

final class Log {
    static func error(_ message: String) {
        os_log("%@", log: .default, type: .error, message)
    }

    static func debug(_ message: String) {
        os_log("%@", log: .default, type: .debug, message)
    }
}

func failDebug(_ logMessage: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    let formattedMessage = formatLogMessage(logMessage, file: file, function: function, line: line)
    Log.debug(formattedMessage)
    assertionFailure(formattedMessage, file: file, line: line)
}

func fail(_ logMessage: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Never {
    Log.error(formatLogMessage(logMessage, file: file, function: function, line: line))
    fatalError(logMessage, file: file, line: line)
}

func notImplemented(file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Never {
    fail("Method not implemented.", file: file, function: function, line: line)
}

func formatLogMessage(_ logString: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> String {
    let filename = (file.withUTF8Buffer {
        String(decoding: $0, as: UTF8.self)
    } as NSString).lastPathComponent
    return "[\(filename):\(line) \(function)]: \(logString)"
}

func assertDebug(_ condition: @autoclosure () -> Bool, _ logMessage: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    #if DEBUG
        if !condition() {
            failDebug(logMessage, file: file, function: function, line: line)
        }
    #endif
}

