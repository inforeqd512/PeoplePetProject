//
//  Copyright © 2017 ANZ. All rights reserved.
//

import Foundation

private class BundleIdentifyingClass { }

extension Mocks {

    static func response(_ fileName: String) -> String {

        let emptyJSON = "[]"

        guard let path = Bundle(for: BundleIdentifyingClass.self).path(forResource: fileName, ofType: nil) else {
            return emptyJSON
        }

        guard let data = try? Data(contentsOf: URL(string: "file://\(path)")!, options: Data.ReadingOptions.uncached) else {
            return emptyJSON
        }

        guard let jsonString = String(data: data, encoding: String.Encoding.utf8) else {
            return emptyJSON
        }

        return jsonString
    }

}

struct Mocks {

    static func find(_ request: URLRequest ) -> Data? {
        guard let parts = (request.url?.pathComponents)
            else { return nil }

        let suffix = parts.suffix(2).map { idx in return idx }
        let fileName = suffix[1] //+ suffix[1]
        let loadJSON = response(fileName)
        let data = loadJSON.data(using: String.Encoding.utf8)
        return data

    }
}
