//
//  IPRange.swift
//  App
//
//  Created by BinaryBoy on 8/12/19.
//

import FluentSQLite
import Vapor

final class IPRange: Content {
    var id: Int?
    var from: Int
    var to: Int
    var countrycode: String
    var country: String

    init(id:Int, from: Int,to:Int,countrycode:String, country: String) {
        self.id = id
        self.from = from
        self.to = to
        self.countrycode = countrycode
        self.country = country
    }

    public static var entity: String {
        return "IP2LOCATION"
    }
}
extension IPRange: SQLiteModel, Migration, Parameter { }
