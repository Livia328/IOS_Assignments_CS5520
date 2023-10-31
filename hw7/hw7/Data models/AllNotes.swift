//
//  AllNotes.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

//"notes": [
//        {
//            "_id": "6481e210eb428dfc098ca1a1",
//            "userId": "6473a12fef6a54cf06e90f80",
//            "text": "So tired",
//            "__v": 0
//        },
//        {
//            "_id": "6481e377eb428dfc098ca1ae",
//            "userId": "6473a12fef6a54cf06e90f80",
//            "text": "Bank,.",
//            "__v": 0
//        }]

import Foundation

struct Note: Codable {
    let _id: String
    let userId: String
    let text: String
    let __v: Int
}

struct AllNotes: Codable {
    let notes: [Note]
}

