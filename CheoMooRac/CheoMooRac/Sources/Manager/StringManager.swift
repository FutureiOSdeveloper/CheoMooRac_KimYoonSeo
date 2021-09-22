//
//  StringManager.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/22.
//

import Foundation

struct StringManager {
    static let shared = StringManager()
    
    let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    
    func chosungCheck(word: String) -> String {
        let octal = word.unicodeScalars[word.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        return hangul[Int(index)]
    }
}
