//
//  JSONFileReader.swift
//  
//
//  Created by Brian Murphy on 13/02/2020.
//

import Foundation

public class JSONFileReader {
    enum Error: Swift.Error {
        case fileNotFound
    }

    public static let shared: JSONFileReader = JSONFileReader()
    private var fileCache: [String: URL] = [:]

    private init() {
        populateCache()
    }

    private func populateCache() {
        let JSONFilesDir = constructJSONFilesDirectory()
        let enumerator = FileManager.default.enumerator(at: JSONFilesDir,
                                                        includingPropertiesForKeys: [.nameKey],
                                                        options: [],
                                                        errorHandler: { _,_ in return true })

        for case let url as URL in enumerator! where url.isFileURL {
            fileCache[url.lastPathComponent] = url
        }
    }

    public func jsonFile(named: String) throws -> URL {
        guard let url = fileCache[named] else {
            throw Error.fileNotFound
        }
        return url
    }

    public func jsonData(from fileName: String) throws -> Data {
        let file = try jsonFile(named: fileName)
        let data = try Data(contentsOf: file)
        return data
    }

    func constructJSONFilesDirectory() -> URL {
        var currentFileURL = URL(fileURLWithPath: "\(#file)", isDirectory: false)
        while currentFileURL.lastPathComponent != "UNogsAPITests" {
            currentFileURL.deleteLastPathComponent()
        }
        currentFileURL.appendPathComponent("JSON")
        currentFileURL.appendPathComponent("Files")
        return currentFileURL
    }

}

