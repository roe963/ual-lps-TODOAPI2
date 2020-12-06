import Fluent

struct CreateSubject: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("subjects")
            .id()
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("subjects").delete()
    }
}
