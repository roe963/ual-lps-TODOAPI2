import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "finished")
    var finished: Bool
    
    @Field(key: "subjectid")
    var subjectid: UUID

    init() { }

    init(id: UUID? = nil, title: String, subjectid: UUID) {
        self.id = id
        self.title = title
        self.finished = false
        self.subjectid = subjectid
    }
    
    func finish() {
        finished = true
    }
}
