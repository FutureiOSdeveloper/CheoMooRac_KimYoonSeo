//
//  MainViewModel.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/23.
//

import Foundation

protocol MainViewModelInput {
    
}

protocol MainViewModelOutput {
    var list:  Dynamic<[String]> {get}
    var sectionHeaderList: Dynamic<[String]> {get}
}

protocol MainViewModelProtocol : MainViewModelInput,MainViewModelOutput {}

class MainViewModel: MainViewModelProtocol {

   //  MARK: - OUTPUT
    let list: Dynamic<[String]> = Dynamic([])
    let sectionHeaderList: Dynamic<[String]> = Dynamic([])
    
//    private var filteredList: [String] = []
//    private var filterdHeaderList: [String] = []
    //    private var list = ["김윤서", "김루희", "윤예지", "김혜수", "코코", "민재", "잼권이", "리헤이", "노제", "몬익화", "립제이", "잘린이", "엠마", "모아나", "케이데이", "가비", "시미즈zz", "강호동", "이수근", "유재석", "리정" ]
//
//    private var filteredList: [String] = []
//    private var filterdHeaderList: [String] = []
//
//    private var sectionHeaderList: [String] {
//        var sectionHeaderList: [String] = []
//        list.forEach { name in
//            sectionHeaderList.append(StringManager.shared.chosungCheck(word: name))
//        }
//
//        return Array(Set(sectionHeaderList)).sorted()
//    }
    
//    var sectionHeaderList$: [String] {
//          var sectionHeaderList: [String] = []
//       self.list?.forEach { name in
//              sectionHeaderList.append(StringManager.shared.chosungCheck(word: name))
//          }
//
//          return Array(Set(sectionHeaderList)).sorted()
//      }
    
    init() {
        self.list.value =  ["김윤서", "김루희", "윤예지", "김혜수", "코코", "민재", "잼권이", "리헤이", "노제", "몬익화", "립제이", "잘린이", "엠마", "모아나", "케이데이", "가비", "시미즈zz", "강호동", "이수근", "유재석", "리정" ]
        
        var sectionHeaderList$: [String] = []
        self.list.value.forEach { name in
            sectionHeaderList$.append(StringManager.shared.chosungCheck(word: name))
        }
        
        self.sectionHeaderList.value = Array(Set(sectionHeaderList$)).sorted()
    }
}
