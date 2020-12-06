import Fluent
import Vapor

struct SubjectController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let subjects = routes.grouped("subjects")
        subjects.get(use: index)
        subjects.post(use: create)
        subjects.group(":subjectID") { subject in
            subject.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Subject]> {
        return Subject.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Subject> {
        let subject = try req.content.decode(Subject.self)
        return subject.save(on: req.db).map { subject }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Subject.find(req.parameters.get("subjectID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
