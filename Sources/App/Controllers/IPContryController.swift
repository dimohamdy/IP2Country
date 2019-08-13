import Vapor
import FluentSQLite

final class IPContryController {

    func index(_ req: Request) throws -> Future<Country> {
        return getCountry(req)
    }
    
     func getCountry(_ req: Request) ->  Future<Country> {
        return getCountry(req, ipAdress: req.http.remotePeer.hostname!)
    }
    
    
    func getCountry(_ req: Request,ipAdress:String) -> Future<Country> {
        let clientIP = convertIPtoLong(ipAdress: ipAdress)
        
        return IPRange.query(on: req).filter(\IPRange.from <= clientIP ).filter(\IPRange.to >= clientIP).first().flatMap({ipRange -> EventLoopFuture<Country> in
            return Country.query(on: req).filter(\Country.iso_code_2 == ipRange!.countrycode ).first().unwrap(or: Abort.init(HTTPResponseStatus.notFound))
            
        })
    }
    
     private func convertIPtoLong(ipAdress:String) -> Int {
        
        let numbers = ipAdress.components(separatedBy: ["."]).compactMap { Decimal(string:$0) }
        var sum: Decimal = 0
        
        for (index ,number) in numbers.enumerated() {
            let power = 3 - index;
           sum += number * pow(256,power)
        }
        let result = NSDecimalNumber(decimal: sum).intValue
        return  result

    }
    
}
