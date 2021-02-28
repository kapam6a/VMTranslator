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
    func pop(_ segment: String, _ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() + // Put i into register D
        "@\(segment)".addNewLine() +
        "A=D+M".addNewLine() + // Calculate memory address of i and select this memory
        "D=A".addNewLine() + // Put memory address into D register
        "@addr".addNewLine() + // Define new variable
        "M=D".addNewLine() + // Put address of local variable into new variable
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() + // Decrease stack pointer and put value into register new value into register A and variable SP
        "D=M".addNewLine() + // Put value from stack into register D
        "@addr".addNewLine() +
        "A=M".addNewLine() + // Select saved address
        "M=D".addNewLine() // write value into memory
    }
    
    func push(_ segment: String, _ index: Int) -> String {
        "@\(index)".addNewLine() +
        "D=A".addNewLine() + // Put i into register D
        "@\(segment)".addNewLine() +
        "A=D+M".addNewLine() + // Calculate memory address of i and select this memory
        "D=M".addNewLine() + // Put value of selected variable into D register
        "@SP".addNewLine() +
        "A=M".addNewLine() +
        "M=D".addNewLine() + // Put selected variable into stack
        "@SP".addNewLine() +
        "M=M+1".addNewLine() // Increase stack
    }
}

private extension Code {

    func generateAdd() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "M=M+D".addNewLine()
    }

    func generateSub() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "M=M-D".addNewLine()
    }

    func generateNeg() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=-M".addNewLine()
    }

    func generateEq() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@EQUAL_TRUE".addNewLine() +
        "D;JEQ".addNewLine() +
        "D=0".addNewLine() +
        "@END_EQUAL".addNewLine() +
        ";JMP".addNewLine() +
        "(EQUAL_TRUE)".addNewLine() +
        "D=-1".addNewLine() +
        "(END_EQUAL)".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateGt() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@GREATER_TRUE".addNewLine() +
        "D;JGT".addNewLine() +
        "D=0".addNewLine() +
        "@END_GREATER".addNewLine() +
        ";JMP".addNewLine() +
        "(GREATER_TRUE)".addNewLine() +
        "D=-1".addNewLine() +
        "(END_GREATER)".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateLt() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "D=M-D".addNewLine() +
        "@LESS_TRUE".addNewLine() +
        "D;JLT".addNewLine() +
        "D=0".addNewLine() +
        "@END_LESS".addNewLine() +
        ";JMP".addNewLine() +
        "(LESS_TRUE)".addNewLine() +
        "D=-1".addNewLine() +
        "(END_LESS)".addNewLine() +
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D".addNewLine()
    }

    func generateAnd() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D&M".addNewLine()
    }

    func generateOr() -> String {
        "@SP".addNewLine() +
        "AM=M-1".addNewLine() +
        "D=M".addNewLine() +
        "A=M-1".addNewLine() +
        "M=D|M".addNewLine()
    }

    func generateNot() -> String {
        "@SP".addNewLine() +
        "A=M-1".addNewLine() +
        "M=!M".addNewLine()
    }
}
