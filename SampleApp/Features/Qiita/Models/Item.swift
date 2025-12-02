//
//  Item.swift
//  SampleApp
//
//

import Foundation

struct Item: Decodable, Identifiable {
    let id: String
    let title: String
    let body: String?
    let url: String
    let user: User
}
