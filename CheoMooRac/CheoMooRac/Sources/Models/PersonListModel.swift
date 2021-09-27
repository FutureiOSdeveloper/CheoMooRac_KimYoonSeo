//
//  PersonList.swift
//  CheoMooRac
//
//  Created by 김윤서 on 2021/09/27.
//


struct PersonListModel {
    private var data: [Person]?
    
    init() {
        self.data = [Person(firstName: "윤서", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "루희", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "예지", familyName: "윤", phoneNumber: "010-7777-7777"),
                     Person(firstName: "혜수", familyName: "김", phoneNumber: "010-7777-7777"),
                     Person(firstName: "리헤이", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "제", familyName: "노", phoneNumber: "010-7777-7777"),
                     Person(firstName: "엠마", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "모아나", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "민재", familyName: "곽", phoneNumber: "010-7777-7777"),
                     Person(firstName: "케이데이", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "가비", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "시미즈", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "호동", familyName: "강", phoneNumber: "010-7777-7777"),
                     Person(firstName: "재석", familyName: "유", phoneNumber: "010-7777-7777"),
                     Person(firstName: "리정", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "몬익화", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "코코", familyName: "", phoneNumber: "010-7777-7777"),
                     Person(firstName: "잼권", familyName: "", phoneNumber: "010-7777-7777")
                     
  ]
    }
  
    func getPersonList() -> [Person]{
        return data ?? []
    }
}
