import Vapor
import Stencil
import PathKit

public final class StencilProvider: Provider {
    
    public init() {}
    
    public static var path = "Resources/Views/"
    
    static let stencilPathStr = DirectoryConfig.detect().workDir + path
    static let stencilPath = Path(stencilPathStr)
    static let loader: Loader = FileSystemLoader(paths: [stencilPath])
    
    public func register(_ services: inout Services) throws {
        services.register([ViewRenderer.self]) { container -> StencilRenderer in
            return try StencilRenderer.init(using: container)
        }
    }
    
    public func didBoot(_ container: Container) throws -> Future<Void> {
        return Future.done(on: container)
    }
}

public final class StencilRenderer: Service {
    
    private let container: Container
    private let stencilEnvironment: Stencil.Environment

    init(using container: Container) throws {
        let directoryConfig = DirectoryConfig.detect()
        let stencilPathStr = directoryConfig.workDir + StencilProvider.path
        let stencilPath = Path(stencilPathStr)
        let loader: Loader = FileSystemLoader(paths: [stencilPath])
        self.stencilEnvironment = Stencil.Environment(loader: loader)
        self.container = container
    }
    
    public func render(_ path: String, _ context: [AnyHashable : Any]) -> Future<View> {
            let promiseView: Promise<View> = container.eventLoop.newPromise(View.self)
            
            DispatchQueue.global().async {
                do {
                    let rendered: String = try self.stencilEnvironment.renderTemplate(
                        name: path,
                        context: context as? [String : Any]
                    )
                    
                    let renderedData = Data(rendered.utf8)
                    let view: View = View(data:renderedData)
                    return promiseView.succeed(result: view)
                }
                catch let err {
                    promiseView.fail(error: err)
                }
            }
            return promiseView.futureResult
    }
}

public extension Request {
    func render(_ path: String, _ context: [AnyHashable: Any]) throws -> Future<View> {
        let stencilRender = try self.make(StencilRenderer.self)
        return stencilRender.render(path, context)
    }
}
