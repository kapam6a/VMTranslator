//
//  CodeWritter.swift
//  VMTranslator
//

import Foundation

final class Code {
    
    private let prefix: String

    init(_ prefix: String) {
        self.prefix = prefix
    }

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
        default: return "--wrongArithmeticCommand--"
        }
    }

    /*
     Writes to the output file the assembly code that implements the given command,
     where command is either c_push or c_pop.
     */
    func pop(_ segment: String, _ index: Int) -> String {
        switch segment {
        case "local": return generatePopLocal(index)
        case "argument": return generatePopArgument(index)
        case "this": return generatePopThis(index)
        case "that": return generatePopThat(index)
        case "temp": return generatePopTemp(index)
        case "static": return generatePopStatic(index)
        case "pointer": return generatePopPointer(index)
        default: return "--wrongPopCommand--"
        }
    }
    
    func push(_ segment: String, _ index: Int) -> String {
        switch segment {
        case "local": return generatePushLocal(index)
        case "argument": return generatePushArgument(index)
        case "this": return generatePushThis(index)
        case "that": return generatePushThat(index)
        case "constant": return generatePushConstant(index)
        case "temp": return generatePushTemp(index)
        case "static": return generatePushStatic(index)
        case "pointer": return generatePushPointer(index)
        default: return "--wrongPushCommand--"
        }
    }
}

private extension Code {

    // MARK: Arithmetic

    func generateAdd() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "M=M+D".addNewLine()
    }

    func generateSub() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "M=M-D".addNewLine()
    }

    func generateNeg() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=-M".addNewLine()
    }

    func generateEq(_ id: String = UUID().uuidString) -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@EQUAL_TRUE_\(id)".addNewLine() +
        "D;JEQ".addNewLine() +
        "D=0".addNewLine() +
        "@END_EQUAL_\(id)".addNewLine() +
        "0;JMP".addNewLine() +
        "(EQUAL_TRUE_\(id))".addNewLine() +
        "D=-1".addNewLine() +
        "(END_EQUAL_\(id))".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateGt(_ id: String = UUID().uuidString) -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@GREATER_TRUE_\(id)".addNewLine() +
        "D;JGT".addNewLine() +
        "D=0".addNewLine() +
        "@END_GREATER_\(id)".addNewLine() +
        "0;JMP".addNewLine() +
        "(GREATER_TRUE_\(id))".addNewLine() +
        "D=-1".addNewLine() +
        "(END_GREATER_\(id))".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateLt(_ id: String = UUID().uuidString) -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@LESS_TRUE_\(id)".addNewLine() +
        "D;JLT".addNewLine() +
        "D=0".addNewLine() +
        "@END_LESS_\(id)".addNewLine() +
        "0;JMP".addNewLine() +
        "(LESS_TRUE_\(id))".addNewLine() +
        "D=-1".addNewLine() +
        "(END_LESS_\(id))".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateAnd() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "M=D&M".addNewLine()
    }

    func generateOr() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=A-1".addNewLine() +
        "M=D|M".addNewLine()
    }

    func generateNot() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=!M".addNewLine()
    }

    // MARK: Pop
    
    func generatePopLocal(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@LCL".addNewLine() +
        "A=D+M".addNewLine() +
        generatePop()
    }
    
    func generatePopArgument(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@ARG".addNewLine() +
        "A=D+M".addNewLine() +
        generatePop()
    }
    
    func generatePopThis(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@THIS".addNewLine() +
        "A=D+M".addNewLine() +
        generatePop()
    }
    
    func generatePopThat(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@THAT".addNewLine() +
        "A=D+M".addNewLine() +
        generatePop()
    }
    
    func generatePopTemp(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@R5".addNewLine() +
        "A=D+A".addNewLine() +
        generatePop()
    }
    
    func generatePopStatic(_ index: Int) -> String {
        "@\(prefix)" + "." + "\(index)".addNewLine() +
        generatePop()
    }

    func generatePopPointer(_ index: Int) -> String {
        switch index {
        case 0: return generatePopPointerThis()
        case 1: return generatePopPointerThat()
        default: return "--wrongPopPointerIndex--"
        }
    }

    func generatePopPointerThis() -> String {
        "@THIS".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        generatePop()
    }

    func generatePopPointerThat() -> String {
        "@THAT".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        generatePop()
    }
    
    func generatePop() -> String {
        "D=A".addNewLine() +
        "@R13".addNewLine() +
        "M=D".addNewLine() +
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "@R13".addNewLine() +
        "A=M".addNewLine() +
        "M=D".addNewLine()
    }

    // MARK: Push
    
    func generatePushLocal(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@LCL".addNewLine() +
        "A=D+M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePushArgument(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@ARG".addNewLine() +
        "A=D+M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePushThis(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@THIS".addNewLine() +
        "A=D+M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePushThat(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@THAT".addNewLine() +
        "A=D+M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePushConstant(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        generatePush()
    }
    
    func generatePushTemp(_ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() +
        "@R5".addNewLine() +
        "A=D+A".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePushStatic(_ index: Int) -> String {
        "@\(prefix)" + "." + "\(index)".addNewLine() +
        "D=A".addNewLine() +
        generatePush()
    }

    func generatePushPointer(_ index: Int) -> String {
        switch index {
        case 0: return generatePushPointerThis()
        case 1: return generatePushPointerThat()
        default: return "--wrongPushPointerIndex--"
        }
    }

    func generatePushPointerThis() -> String {
        "@THIS".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }

    func generatePushPointerThat() -> String {
        "@THAT".addNewLine() +
        "A=M".addNewLine() +
        "D=M".addNewLine() +
        generatePush()
    }
    
    func generatePush() -> String {
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "M=D".addNewLine() +
        "@SP".addNewLine() +
        "M=M+1".addNewLine()
    }
}
