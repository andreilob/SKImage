import Foundation

final class ImageCacher {
    let cache = URLCache(
        memoryCapacity: 100_000_000,
        diskCapacity: 100_000_000,
        directory: .cacheURL
    )
    
    func cacheResponse(
        _ response: CachedURLResponse,
        request: URLRequest
    ) {
        cache.storeCachedResponse(
            response,
            for: request
        )
    }
    
    func getResponse(_ url: URL) -> CachedURLResponse? {
        let request = URLRequest(url: url)
        return cache.cachedResponse(for: request)
    }
    
    func flushCache() {
        cache.removeAllCachedResponses()
    }
    
    func clearCacheEntries(since date: Date) {
        cache.removeCachedResponses(since: date)
    }
    
    func removeResponse(at url: URL) {
        cache.removeCachedResponse(for: URLRequest(url: url))
    }
}

private extension URL {
    static var cacheURL: URL? = FileManager.default.urls(
        for: .cachesDirectory,
        in: .userDomainMask
    ).first?.appendingPathComponent("LA.SKImage.imageCacher")
}
