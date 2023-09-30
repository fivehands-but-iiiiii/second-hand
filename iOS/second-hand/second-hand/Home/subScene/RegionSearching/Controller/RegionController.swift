//
//  RegionController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit
import RxSwift
import RxCocoa

class RegionController {
    var havingCell : [RegionHashable] = []
    
    class RegionHashable: Hashable {
        let name: String
        let regionId : Int
        let identifier = UUID()
        
        init(name: String, regionId: Int) {
            self.name = name
            self.regionId = regionId
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: RegionHashable, rhs: RegionHashable) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }

}

extension RegionController {
        generateRegions { [weak self] regions in
            self?.regions = regions // 비동기 작업이 완료되면 regions 배열 업데이트
        }
    }
}

extension RegionController {
    private func generateRegions(completion: @escaping ([RegionHashable]) -> Void) {
        getRegionList { regionList in
            var regions = [RegionHashable]()
            for region in regionList {
                let name = region.city + " " + region.county + " " + region.district
                let regionId = region.id
                regions.append(RegionHashable(name: name, regionId: regionId))
            }
            
            self.havingCell = regions

            completion(regions)
        }
    }
    
    private func getRegionList(completion: @escaping ([RegionInfo]) -> Void) {
        var regionList: [RegionInfo] = []
        
        let keyword = "서울"
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: Server.shared.createRegionListURL(keyword: encodedKeyword)) else {
            completion(regionList)
            return
        }
        
        NetworkManager.sendGET(decodeType: RegionListFetchedSuccess.self, header: nil, body: nil, fromURL: url) { (result: Result<[RegionListFetchedSuccess], Error>) in
            switch result {
            case .success(let response):
                guard let regions = response.last?.data else {
                    completion(regionList)
                    return
                }
                regionList = regions
                completion(regionList)
                
            case .failure(let error):
                print(error)
                completion(regionList)
            }
        }
    }
}
