//
//  ContactDetailViewModel.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/24.
//

import Foundation

class ContactDetailViewModel {
    var items: [String]
    
    init(person: Person){
        self.items = [person.familyName+person.firstName, person.phoneNumber]
    }
}
