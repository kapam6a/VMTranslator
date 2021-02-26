//
//  VMTranslator.swift
//  VMTranslator
//

import Foundation

final class VMTranslator {

    private let codeWritter: CodeWritter
    private let parser: Parser

    init(_ source: String) {
        self.parser = Parser(source)
        self.codeWritter = CodeWritter()
    }

    func translate() -> String {
        ""
    }
}
