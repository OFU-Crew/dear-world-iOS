//
//  apiMock.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import RxSwift

class APIMock {
    func getMessages(page: Int) -> Observable<[MessageMock]> {
        return Observable.just([
            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
            MessageMock(emoji: "🙃", name: "동영", country: "🍎", countryName: "South Korea", detail: "ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ", likes: 24),
            MessageMock(emoji: "👩🏻‍🚀", name: "선영", country: "💀", countryName: "South Korea", detail: "ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ", likes: 10),
            MessageMock(emoji: "👩🏻‍🚀", name: "용완4", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20)
            
        ])
    }
}
