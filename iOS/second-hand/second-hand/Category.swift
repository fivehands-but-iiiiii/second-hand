//
//  Category.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/27.
//

import Foundation

struct Category {
    static let list = ["디지털기기", "생활가전", "가구/인테리어", "생활/주방", "유아동", "유아도서", "여성의류", "여성잡화", "남성패션/잡화", "뷰티/미용", "스포츠/레저", "취미/게임/음반", "중고차", "티켓/교환권", "가공식품", "반겨동물용품", "식물", "기타 중고물품"]
    
    static func convertCategoryIntToString(_ num: Int) -> String{
        switch num {
        case 1 :
            return "디지털기기"
        case 2 :
            return "생활가전"
        case 3 :
            return "가구/인테리어"
        case 4 :
            return "생활/주방"
        case 5 :
            return "유아동"
        case 6 :
            return "유아도서"
        case 7 :
            return "여상의류"
        case 8 :
            return "여성잡화"
        case 9 :
            return "남성패션/잡화"
        case 10 :
            return "뷰티/미용"
        case 11 :
            return "스포츠/레저"
        case 12 :
            return "취미/게임/음반"
        case 13 :
            return "중고차"
        case 14 :
            return "티켓/교환권"
        case 15 :
            return "가공식품"
        case 16 :
            return "반려동물용품"
        case 17 :
            return "식물"
        case 18 :
            return "기타 중고물품"
        default:
            return "unknown"
        }
    }
    
    static func convertCategoryStringToInt(_ string: String) -> Int {
        switch string {
        case "디지털기기" :
            return 1
        case "생활가전" :
            return 2
        case "가구/인테리어" :
            return 3
        case "생활/주방" :
            return 4
        case "유아동" :
            return 5
        case "유아도서" :
            return 6
        case "여성의류" :
            return 7
        case "여성잡화" :
            return 8
        case "남성패션/잡화" :
            return 9
        case "뷰티/미용" :
            return 10
        case "스포츠/레저" :
            return 11
        case "취미/게임/음반" :
            return 12
        case "중고차" :
            return 13
        case "티켓/교환권" :
            return 14
        case "가공식품" :
            return 15
        case "반려동물용품" :
            return 16
        case "식물" :
            return 17
        case "기타 중고물품" :
            return 18
        default:
            return 19
        }
    }
}
