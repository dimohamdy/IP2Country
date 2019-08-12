import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class IPNation: Content {
    var id: Int?
    var ip: Int
    var country: String

    init(id:Int, ip: Int, country: String) {
        self.id = id
        self.ip = ip
        self.country = country
    }

    public static var entity: String {
        return "IP2Nation"
    }
}


extension IPNation: SQLiteModel, Migration, Parameter { }

final class Country: Content {
    var id: Int?
    var code: String
    var iso_code_2: String
    var iso_code_3: String
    var country: String
    var lat: Float
    var lon: Float

    init(id: Int? = nil, code: String, iso_code_2: String, iso_code_3: String,country:String,lat:Float,lon:Float) {
        self.id = id
        self.code = code
        self.iso_code_2 = iso_code_2
        self.iso_code_3 = iso_code_3
        self.country = country
        self.lat = lat
        self.lon = lon
    }
    public static var entity: String {
        return "Country2"
    }
}
extension Country: SQLiteModel, Migration, Parameter { }
