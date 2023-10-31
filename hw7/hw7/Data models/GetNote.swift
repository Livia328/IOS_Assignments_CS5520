//
//  GetNote.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/31.
//

// "getnote":false,"message":"This is not your note."
import Foundation

struct GetNote: Codable {
    let getnote: Bool?
    let message: String?
}
