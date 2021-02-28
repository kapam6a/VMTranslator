//
//  VMTranslator.swift
//  VMTranslator
//

import Foundation

final class VMTranslator {

    private let code: Code
    private let parser: Parser

    init(_ source: String) {
        self.parser = Parser(source)
        self.code = Code()
    }

    func translate() -> String {
        var result: String = ""
        while parser.hasMoreCommands() {
            parser.advance()
            result += generateCode()
        }
        return result
    }
}

private extension VMTranslator {
    
    func generateCode() -> String {
        switch parser.commandType() {
        case .c_arithmetic: return code.arithmetic(parser.arg1())
        case .c_push: return code.push(parser.arg1(), parser.arg2())
        case .c_pop: return code.pop(parser.arg1(), parser.arg2())
        case .c_label: return ""
        case .c_goto: return ""
        case .c_if: return ""
        case .c_function: return ""
        case .c_return: return ""
        case .c_call: return ""
        }
    }
}
