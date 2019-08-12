import Vapor
import FluentSQLite
import SQLite3

struct SQLiteVersion: Codable {
        let version: String
    }

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic "It works" example
    router.get { req -> Future<[Country]> in
        
        return IPNation.query(on: req).filter(\IPNation.ip == convertIPtoLong(ipAdress: /*req.http.remotePeer.hostname!*/"188.121.96.0")).first().flatMap { ipNation -> Future<[Country]> in
            
            guard let ip = ipNation else {
                throw Abort(.notFound, reason:
                    """
                    This ip \(req.http.remotePeer.hostname!) notmatch country in database
                    please ask @dimohamd to update database
                    """
                )
            }
            return Country.query(on: req).filter(\Country.code == ip.country).all()
        }

    }

}

func convertIPtoLong(ipAdress:String) -> Int {
    
    let numbers = ipAdress.components(separatedBy: ["."]).compactMap { Decimal(string:$0) }
    var sum: Decimal = 0
    
    for (index ,number) in numbers.enumerated() {
        let power = 3 - index;
       sum += number * pow(256,power)
    }
    let result = NSDecimalNumber(decimal: sum).intValue
    return  result

}
