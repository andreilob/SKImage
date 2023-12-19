import Foundation

class ImageDownloadTask: NSObject {
    var progress = 0.0
    let url: URL
    
    var response: (CachedURLResponse, URLRequest) {
        get async throws {
            defer { completionHandler() }
            let request = URLRequest(url: url, timeoutInterval: timeoutDuration)
            let (data, response) = try await urlSession.data(for: request, delegate: self)
            return (CachedURLResponse(response: response, data: data), request)
        }
    }
    
    private let urlSession: URLSession
    private let timeoutDuration: TimeInterval
    private let completionHandler: (() -> Void)
    private var progressObservation: NSKeyValueObservation?
    
    init(
        urlSession: URLSession,
        url: URL,
        timeoutDuration: TimeInterval,
        completionHandler: @escaping (() -> Void)
    ) {
        self.urlSession = urlSession
        self.url = url
        self.timeoutDuration = timeoutDuration
        self.completionHandler = completionHandler
    }
}

// MARK: - URLSessionTaskDelegate
extension ImageDownloadTask: URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        didCreateTask task: URLSessionTask
    ) {
        progressObservation = task.progress.observe(\.fractionCompleted) { [weak self] progress, value in
            guard let self else { return }
            self.progress = progress.fractionCompleted
        }
    }
}
