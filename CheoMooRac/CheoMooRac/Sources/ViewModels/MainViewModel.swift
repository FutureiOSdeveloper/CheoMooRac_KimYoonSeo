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
    var viewDidLoad: Signal<[[Person]]>?{get}
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
    var viewDidLoad: Signal<[[Person]]>?
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    init(with model: PersonListModel) {
        var sectionHeaderList$: [String] = []
        var sectionPeopleArray$: [[Person]] = [[]]
        var searchText: String = ""
        var filteredData: [Person] = []
        
        viewDidLoad = Signal.just(model.getPersonList())
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
                
            }).asSignal(onErrorJustReturn: [model.getPersonList()])
        
        filtering = searchBarText
            .map({ text -> Bool in
                guard let text = text else {return false}
                if text.isEmpty {
                    return false
                } else {
                    searchText = text
                    return true
                }
            }).asSignal(onErrorJustReturn: false)
        
        sectionPeopleArray = searchBarText
            .map({ text -> Bool in
                guard let text = text else {return false}
                if text.isEmpty {
                    return false
                } else {
                    searchText = text
                    return true
                }
            })
            .map({ filtered -> [Person] in
                if filtered {
                        filteredData = model.getPersonList().filter {($0.familyName+$0.firstName).localizedCaseInsensitiveContains(searchText) }
                    return filteredData
                } else {
                    return model.getPersonList()
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
                
            }).asSignal(onErrorJustReturn: [[]])
    }

}
