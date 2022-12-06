//
//  Person.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2022/11/22.
//

struct Person {
    var firstName: String
    var familyName: String
    var phoneNumber: String

    func contains(_ text: String) -> Bool {
        return (familyName + firstName).contains(text)
    }

    var full: String {
        return familyName + firstName
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.full < rhs.full
    }
}

struct PersonList {
    static let shared = PersonList()

    private var data: [Person]

    private init() {
        self.data = [Person(firstName: "윤서", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "현진", familyName: "류", phoneNumber: "010-7777-7777"),
                     Person(firstName: "흥민", familyName: "손", phoneNumber: "010-7777-7777"),
                     Person(firstName: "영웅", familyName: "임", phoneNumber: "010-7777-7777"),
                     Person(firstName: "준서", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "화랑", familyName: "임", phoneNumber: "010-7777-7777"),
                     Person(firstName: "기범", familyName: "빙", phoneNumber: "010-7777-7777"),
                     Person(firstName: "소진", familyName: "이", phoneNumber: "010-7777-7777"),
                     Person(firstName: "재연", familyName: "박", phoneNumber: "010-7777-7777"),
                     Person(firstName: "선경", familyName: "남", phoneNumber: "010-7777-7777"),
                     Person(firstName: "혜민", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "혜연", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "호동", familyName: "강", phoneNumber: "010-7777-7777"),
                     Person(firstName: "재석", familyName: "유", phoneNumber: "010-7777-7777"),
                     Person(firstName: "해니", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "서준", familyName: "박", phoneNumber: "010-7777-7777"),
                     Person(firstName: "지효", familyName: "송", phoneNumber: "010-7777-7777"),
                     Person(firstName: "은우", familyName: "차", phoneNumber: "010-7777-7777"),
                     Person(firstName: "종원", familyName: "백", phoneNumber: "010-7777-7777"),
                     Person(firstName: "빈", familyName: "현", phoneNumber: "010-7777-7777"),
                     Person(firstName: "수지", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "지훈", familyName: "주", phoneNumber: "010-7777-7777"),

  ]
    }

    func getPersonList() -> [Person]{
        return data ?? []
    }

    mutating func append(_ person: Person) {
        data.append(person)
    }
}
