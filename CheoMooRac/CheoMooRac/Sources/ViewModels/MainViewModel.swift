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
    var list:  Dynamic<[Person]> {get}
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
    let list: Dynamic<[Person]> = Dynamic([])
    let sectionHeaderList: Dynamic<[String]> = Dynamic([])
    let nowRefreshing: Dynamic<Bool> = Dynamic(false)
    let sectionArray: Dynamic<[String]> = Dynamic([])
    
    func getSectionArray(at section: Int) -> Dynamic<[String]>  {
        
        let list$ = self.list.value.filter {
            return StringManager.shared.chosungCheck(word: $0.familyName + $0.firstName) == sectionHeaderList.value[section-1]
        }.map { person in
            return person.familyName + person.firstName
        }
        
        return Dynamic(list$)
    }
    
    
    init() {
        self.list.value = [Person(firstName: "윤서", familyName: "김", phoneNumber: "010-6515-6030"),
                           Person(firstName: "루희", familyName: "김", phoneNumber: "010-6515-6030"),
                           Person(firstName: "예지", familyName: "윤", phoneNumber: "010-6515-6030"),
                           Person(firstName: "혜수", familyName: "김", phoneNumber: "010-6515-6030"),
                           Person(firstName: "리헤이", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "제", familyName: "노", phoneNumber: "010-6515-6030"),
                           Person(firstName: "엠마", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "모아나", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "민재", familyName: "곽", phoneNumber: "010-6515-6030"),
                           Person(firstName: "케이데이", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "가비", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "시미즈", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "호동", familyName: "강", phoneNumber: "010-6515-6030"),
                           Person(firstName: "재석", familyName: "유", phoneNumber: "010-6515-6030"),
                           Person(firstName: "리정", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "몬익화", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "코코", familyName: "", phoneNumber: "010-6515-6030"),
                           Person(firstName: "잼권", familyName: "", phoneNumber: "010-6515-6030")
                           
        ]
        
        var sectionHeaderList$: [String] = []
        self.list.value.forEach { person in
            sectionHeaderList$.append(StringManager.shared.chosungCheck(word: person.familyName + person.firstName))
        }
        
        self.sectionHeaderList.value = Array(Set(sectionHeaderList$)).sorted()
    }
}
