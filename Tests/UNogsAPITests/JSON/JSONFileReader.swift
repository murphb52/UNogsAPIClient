//
//  JSONFileReader.swift
//  
//
//  Created by Brian Murphy on 13/02/2020.
//

import Foundation

public class JSONFileReader {

    public static let shared: JSONFileReader = JSONFileReader()
    private var fileCache: [String: URL] = [:]

    private init() {
        populateCache()
    }

    private func populateCache() {
        let baseURL = urlForCurrentDir()
        let enumerator = FileManager.default.enumerator(at: baseURL,
                                       includingPropertiesForKeys: [.nameKey],
                                       options: []) { (url, error) -> Bool in
                                        return false
        }

        for case let url as URL in enumerator! where url.isFileURL {
            fileCache[url.lastPathComponent] = url
        }
    }

    public func jsonFile(named: String) -> URL? {
        return fileCache[named]
    }

    func urlForCurrentDir() -> URL {
        var currentFileURL = URL(fileURLWithPath: "\(#file)", isDirectory: false)
        while currentFileURL.lastPathComponent != "UNogsAPITests" {
            currentFileURL.deleteLastPathComponent()
        }
        currentFileURL.appendPathComponent("JSON")
        currentFileURL.appendPathComponent("Files")
        return currentFileURL
    }

}
