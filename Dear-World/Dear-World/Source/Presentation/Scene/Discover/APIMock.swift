//
//  apiMock.swift
//  Dear-World
//
//  Created by rookie.w on 2020/12/27.
//

import RxSwift
import UIKit
class APIMock {
  
  func getMessages(page: Int, country: String) -> Observable<Message.Model.Messages> {
        return
          Observable
          .just(Message.Model.Messages(firstMsgId: 0, lastMsgId: 1, messageCount: 20, messages: [
            
          ]))
//          .just([
//            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "\(Date())", likes: 20),
//            MessageMock(emoji: "🙃", name: "동영", country: "🍎", countryName: "South Korea", detail: "ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ", likes: 24),
//            MessageMock(emoji: "👩🏻‍🚀", name: "선영", country: "💀", countryName: "South Korea", detail: "ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ", likes: 10),
//            MessageMock(emoji: "👩🏻‍🚀", name: "용완4", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
//            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
//            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20),
//            MessageMock(emoji: "🎅🏻", name: "용완", country: "🇰🇷", countryName: "South Korea", detail: "iasjdliajdliajsdliajdsilajsdliajsdlajdasjdlajsdliajsldiajsd", likes: 20)
//
//        ])
//          .delay(.seconds(1), scheduler: MainScheduler.instance)
    }
}
