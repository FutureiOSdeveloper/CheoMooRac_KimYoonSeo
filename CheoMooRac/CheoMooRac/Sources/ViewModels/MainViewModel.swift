//
//  MainViewModel.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/23.
//

import Foundation

protocol MainViewModelInput {
    func refreshTableView()
}

protocol MainViewModelOutput {
    var list:  Dynamic<[String]> {get}
    var sectionHeaderList: Dynamic<[String]> {get}
    var nowRefreshing: Dynamic<Bool> {get}
    var sectionArray: Dynamic<[String]> {get}
    func getSectionArray(at section: Int) -> Dynamic<[String]>
}

protocol MainViewModelProtocol : MainViewModelInput,MainViewModelOutput {}

class MainViewModel: MainViewModelProtocol {
    //  MARK: - INPUT
    func refreshTableView() {
        if !nowRefreshing.value {
            nowRefreshing.value = true
            //refreshing logic
            nowRefreshing.value = false
        }
    }
    

   //  MARK: - OUTPUT
    let list: Dynamic<[String]> = Dynamic([])
    let sectionHeaderList: Dynamic<[String]> = Dynamic([])
    let nowRefreshing: Dynamic<Bool> = Dynamic(false)
    let sectionArray: Dynamic<[String]> = Dynamic([])
    
    func getSectionArray(at section: Int) -> Dynamic<[String]>  {
        
        let list$ = self.list.value.filter {
            return StringManager.shared.chosungCheck(word: $0) == sectionHeaderList.value[section-1]
        }
        return Dynamic(list$)
    }
    
    
    init() {
        self.list.value =  ["김윤서", "김루희", "윤예지", "김혜수", "코코", "민재", "잼권이", "리헤이", "노제", "몬익화", "립제이", "잘린이", "엠마", "모아나", "케이데이", "가비", "시미즈zz", "강호동", "이수근", "유재석", "리정" ]
        
        var sectionHeaderList$: [String] = []
        self.list.value.forEach { name in
            sectionHeaderList$.append(StringManager.shared.chosungCheck(word: name))
        }
        
        self.sectionHeaderList.value = Array(Set(sectionHeaderList$)).sorted()
    }
}
