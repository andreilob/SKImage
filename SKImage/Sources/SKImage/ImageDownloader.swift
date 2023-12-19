import Foundation

final class ImageDownloader {
    var timeoutInterval = 60.0
    
    private let urlSession: URLSession
    private var tasks: [ImageDownloadTask] = []
    
    init(cache: URLCache) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        self.urlSession = URLSession(configuration: configuration)
    }
    
    func downloadImage(url: URL) async throws -> (CachedURLResponse, URLRequest) {
        guard let task = tasks.first(where: { $0.url == url }) else {
            return try await createImageTask(url: url)
        }
        return try await task.response
    }
    
    private func createImageTask(url: URL) async throws -> (CachedURLResponse, URLRequest) {
        let task = ImageDownloadTask(
            urlSession: urlSession,
            url: url,
            timeoutDuration: timeoutInterval,
            completionHandler: { [weak self] in
                guard let self else { return }
                tasks.removeAll(where: { $0.url == url })
            }
        )
        tasks.append(task)
        return try await task.response
    }
}
