//
//  Parser.swift
//  VMTranslator
//

import Foundation

enum Command {
    case c_arithmetic
    case c_push
    case c_pop
    case c_label
    case c_goto
    case c_if
    case c_function
    case c_return
    case c_call
}


final class Parser {

    private let lines: [String]
    private var currentCommand: String = ""
    private var currentIndex: Int = 0

    init(_ source: String) {
        self.lines = source.components(separatedBy: .newlines).map { String($0) }.filter { !$0.isEmpty }
    }

    /*
     Are there more commands in the input?
     */
    func hasMoreCommands() -> Bool {
        while lines.count > currentIndex {
            if lines[currentIndex].hasPrefix("//") {
                currentIndex += 1
            } else {
                return true
            }
        }
        return false
    }

    /*
     Reads the next command from
     the input and makes it the current command. Should be called only
     if hasMoreCommands() is true. Initially there is no current command.
     */
    func advance() {
        let currentLine = lines[currentIndex]
        currentCommand = currentLine.components(separatedBy: "//").first!
        currentIndex += 1
    }

    /*
     Returns a constant representing the type of the current command.
     c_arethmetic is returned for all the arithmetic/logical commands.
     */
    func commandType() -> Command {
        if currentCommand.contains("pop") {
            return .c_pop
        } else if currentCommand.contains("push") {
            return .c_push
        } else if currentCommand.contains("label") {
            return .c_label
        }  else if currentCommand.contains("goto") {
            return .c_goto
        }  else if currentCommand.contains("if") {
            return .c_if
        } else if currentCommand.contains("function") {
            return .c_function
        } else if currentCommand.contains("call") {
            return .c_call
        } else if currentCommand.contains("return") {
            return .c_return
        } else {
            return .c_arithmetic
        }
    }

    /*
     Returns the first argument of the current command.
     In the case of c_arithmetic, command itself (add, sub, etc) is returned.
     Should not be called if the current command is c_return.
     */
    func arg1() -> String {
        let components = currentCommand.components(separatedBy: .whitespaces)
        if components.count == 1 {
            return components[0]
        } else {
            return components[1]
        }
    }

    /*
     Returns the second argument of the current command.
     Should be called if the current command is c_push, c_pop, c_function or c_call.
     */
    func arg2() -> Int {
        let components = currentCommand.components(separatedBy: .whitespaces)
        return Int(components[2])!
    }
}
