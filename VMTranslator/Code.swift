//
//  CodeWritter.swift
//  VMTranslator
//

final class Code {

    /*
     Writes to the output file the assembly code that implemetns the given arithmetic command.
     */
    func arithmetic(_ value: String) -> String {
        switch value {
        case "add": return generateAdd()
        case "sub": return generateSub()
        case "neg": return generateNeg()
        case "eq": return generateEq()
        case "gt": return generateGt()
        case "lt": return generateLt()
        case "and": return generateAnd()
        case "or": return generateOr()
        case "not": return generateNot()
        default: return "----"
        }
    }

    /*
     Writes to the output file the assembly code that implements the given command,
     where command is either c_push or c_pop.
     */
    func pushPop(_ command: Command, _ segment: String, _ index: Int) -> String {
        switch command {
        case .c_pop: return generatePop(segment, index)
        case .c_push: return generatePush(segment, index)
        default: return "-----"
        }
    }
}

extension Code {

    func generateAdd() -> String {
        "@SP".addNewLine() +
        "M=M-1".addNewLine() +
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=M+D".addNewLine()
    }

    func generateSub() -> String {
        "@SP".addNewLine() +
        "M=M-1".addNewLine() +
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=M-D".addNewLine()
    }

    func generateNeg() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=-M".addNewLine()
    }

    func generateEq() -> String {
        ""
    }

    func generateGt() -> String {
        ""
    }

    func generateLt() -> String {
        ""
    }

    func generateAnd() -> String {
        "@SP".addNewLine() +
        "M=M-1".addNewLine() +
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D&M".addNewLine()
    }

    func generateOr() -> String {
        "@SP".addNewLine() +
        "M=M-1".addNewLine() +
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D|M".addNewLine()
    }

    func generateNot() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=!M".addNewLine()
    }

    func generatePop(_ segment: String, _ index: Int) -> String {
        ""
    }

    func generatePush(_ segment: String, _ index: Int) -> String {
        ""
    }
}
