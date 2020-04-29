import Vapor
import StencilProvider

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get { req -> Future<View> in
        struct Server: Codable {
            let name: String
        }
        
        let context: [String: Codable] = [
            "servers": [
                Server(name: "Vapor"),
                Server(name: "Django"),
                Server(name: "NodeJS")
            ]
        ]
        
        return try req.render("servers.html", context)
    }
}
