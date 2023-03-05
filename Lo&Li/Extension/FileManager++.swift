//
//  FileManagerExtensions.swift
//  SwifterSwift
//
//  Created by Jason Jon E. Carreos on 05/02/2018.
//  Copyright © 2018 SwifterSwift
//

import Foundation
import KakaJSON

// MARK: - 创建文件夹

public extension FileManager {
    func createFolder(folderName: String, for directory: SearchPathDirectory = .cachesDirectory) -> URL {
        let folderParentURL = FileManager.default.urls(for: directory, in: .userDomainMask)[0]
        let folderURL = folderParentURL.appendingPathComponent(folderName)
        do {
            try createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL
        } catch {
            return folderURL
        }
    }
}

public extension Convertible {
    func cacheOnDisk(fileName: String, folder: String = "FantasyCacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) {
        let file = Self.fileURL(forFolder: folder, for: directory, fileName: fileName)
        write(self, to: file)
    }

    static func getForDisk(fileName: String, folder: String = "FantasyCacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) -> Self? {
        let file = fileURL(forFolder: folder, for: directory, fileName: fileName)
        return read(self, from: file)
    }

    private static func fileURL(forFolder folder: String, for directory: FileManager.SearchPathDirectory, fileName: String) -> URL {
        let type = String(describing: self)
        let file = "\(type)-\(fileName).json"
        let folderURL = FileManager.default.createFolder(folderName: folder, for: directory)
        let fileURL = folderURL.appendingPathComponent(file)
        return fileURL
    }
}
