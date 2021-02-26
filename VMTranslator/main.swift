//
//  main.swift
//  VMTranslator
//

import Foundation

if CommandLine.arguments.count < 2 {
    print("Please provide input file name")
    exit(1)
}

let inputFileName = CommandLine.arguments[1]
let fileName = (inputFileName as NSString).deletingPathExtension
let readFileName = fileName + ".vm"
let writeFileName = fileName + ".asm"

do {
    let content = try FileService(fileName: readFileName).read()
    let result = VMTranslator(content).translate()
    try FileService(fileName: writeFileName).write(text: result)
    print(result)
} catch let error as FileServiceError {
    switch error {
    case .readFile:
        print("Could not read the file.")
    case .writeToFile:
        print("Could not save to the file.")
    }
}
