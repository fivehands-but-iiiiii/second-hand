//
//  RegionController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit

class RegionController {
    var havingCell : [RegionHashable] = []
    
    struct RegionHashable: Hashable {
        let name: String
        let regionId : Int
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: RegionHashable, rhs: RegionHashable) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return name.lowercased().contains(lowercasedFilter)
        }
    }
    func filteredRegions(with filter: String?=nil, limit: Int?=nil) -> [RegionHashable] {
        let filtered = regions.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    private lazy var regions: [RegionHashable] = {
        return generateRegions()
    }()
}

extension RegionController {
    private func generateRegions() -> [RegionHashable] {
        let components = regionRawData.components(separatedBy: CharacterSet.newlines)
        var regions = [RegionHashable]()
        for line in components {
            let regionComponents = line.components(separatedBy: ",")
            let name = regionComponents[0]
            guard let regionId = Int(regionComponents[1]) else {
                return []
            }
            regions.append(RegionHashable(name: name, regionId: regionId))
        }
        self.havingCell = regions
        return regions
    }
}

