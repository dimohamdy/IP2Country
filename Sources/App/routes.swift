import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let ipContryController = IPContryController()
    
    router.get { req -> Future<Country> in
        return ipContryController.getCountry(req)
    }

    router.get("ip", String.parameter) { req -> Future<Country> in
        let ipAdress = try req.parameters.next(String.self)
        return ipContryController.getCountry(req, ipAdress: ipAdress)
    }

    router.get(use: ipContryController.index)
    
}


