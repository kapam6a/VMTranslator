//
//  VMTranslator.swift
//  VMTranslator
//

import Foundation

final class VMTranslator {

    private let code: Code
    private let parser: Parser

    init(_ source: String, _ preFix: String) {
        self.parser = Parser(source)
        self.code = Code(preFix)
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
        case .c_label: return code.label(parser.arg1())
        case .c_goto: return code.goTo(parser.arg1())
        case .c_if: return code.if(parser.arg1())
        case .c_function: return code.function(parser.arg1(), parser.arg2())
        case .c_return: return code.return()
        case .c_call: return code.call(parser.arg1(), parser.arg2())
        }
    }
}
