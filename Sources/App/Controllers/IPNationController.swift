import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class IPNationController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[IPNation]> {
        return IPNation.query(on: req).all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<IPNation> {
        return try req.content.decode(IPNation.self).flatMap { ipNation in
            return ipNation.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(IPNation.self).flatMap { ipNation in
            return ipNation.delete(on: req)
        }.transform(to: .ok)
    }
}
