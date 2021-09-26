//
//  MainViewModel.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/23.
//

import Foundation

import RxSwift
import RxCocoa

protocol MainViewModelInput {
    var refreshControlDidPulled: PublishRelay<Void> {get}
    var searchBarText: PublishRelay<String?> {get}
    var cancelButtonDidTapped: PublishRelay<Void> {get}
}

protocol MainViewModelOutput {
    var filtering: Signal<Bool>? {get}
    var sectionPeopleArray: Signal<[[Person]]>? {get}
    var sectionPeopleArrayInit: Signal<[[Person]]>?{get}
}

protocol MainViewModelProtocol : MainViewModelInput, MainViewModelOutput {
    var input : MainViewModelInput { get }
    var output : MainViewModelOutput { get }
}

class MainViewModel: MainViewModelProtocol {
    
    var refreshControlDidPulled: PublishRelay<Void> = PublishRelay<Void>()
    var searchBarText: PublishRelay<String?> = PublishRelay<String?>()
    var cancelButtonDidTapped: PublishRelay<Void> = PublishRelay()

//    var refreshList: Signal<Bool> = Signal.just(false)
    var filtering: Signal<Bool>?
    var sectionPeopleArray: Signal<[[Person]]>?
    var sectionPeopleArrayInit: Signal<[[Person]]>?
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    init() {
        var sectionHeaderList$: [String] = []
        var sectionPeopleArray$: [[Person]] = [[]]
        
        sectionPeopleArrayInit = Signal.just(self.data)
            .map({ people in
                sectionHeaderList$.removeAll()
                sectionPeopleArray$.removeAll()
                
                people.forEach { person in
                    sectionHeaderList$.append(StringManager.shared.chosungCheck(word: person.familyName + person.firstName))
                }
                sectionHeaderList$ = Array(Set(sectionHeaderList$)).sorted()
                
                sectionHeaderList$.forEach { sectionHeader in
                    let list = people.filter {
                        return StringManager.shared.chosungCheck(word: $0.familyName + $0.firstName) == sectionHeader
                    }
                    sectionPeopleArray$.append(list)
                }
                return sectionPeopleArray$
                
            }).asSignal(onErrorJustReturn: [data])
        
        filtering = searchBarText
            .map({ [weak self] text -> Bool in
                guard let self = self else {return false}
                guard let text = text else {return false}
                if text.isEmpty {
                    return false
                } else {
                    self.text = text
                    return true
                }
            }).asSignal(onErrorJustReturn: false)
        
        sectionPeopleArray = searchBarText
            .map({ [weak self] text -> Bool in
                guard let self = self else {return false}
                guard let text = text else {return false}
                if text.isEmpty {
                    return false
                } else {
                    self.text = text
                    return true
                }
            })
            .map({ [weak self] filtered -> [Person] in
                guard let self = self else {return []}
                if filtered {
                        self.filteredData = self.data.filter {($0.familyName+$0.firstName).localizedCaseInsensitiveContains(self.text) }
                    return self.filteredData
                } else {
                    return self.data
                }
            })
            .map({ people in
                sectionHeaderList$.removeAll()
                sectionPeopleArray$.removeAll()
                
                people.forEach { person in
                    sectionHeaderList$.append(StringManager.shared.chosungCheck(word: person.familyName + person.firstName))
                }
                sectionHeaderList$ = Array(Set(sectionHeaderList$)).sorted()
                
                sectionHeaderList$.forEach { sectionHeader in
                    let list = people.filter {
                        return StringManager.shared.chosungCheck(word: $0.familyName + $0.firstName) == sectionHeader
                    }
                    sectionPeopleArray$.append(list)
                }
                return sectionPeopleArray$
                
            }).asSignal(onErrorJustReturn: [data])
    }
    
    //  MARK: - Properties
    private var text: String = ""

    private var filteredData: [Person] = []
    
    private var data =  [Person(firstName: "윤서", familyName: "김", phoneNumber: "010-6515-6030"),
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

}
