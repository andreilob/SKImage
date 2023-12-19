import Foundation

public final class SKImageConfig {
    public static let shared = SKImageConfig()
    
    private let imageCacher: ImageCacher
    private let imageDownloader: ImageDownloader
    
    init() {
        self.imageCacher = ImageCacher()
        self.imageDownloader = ImageDownloader(cache: imageCacher.cache)
    }
    
    public func clearCache() {
        imageCacher.flushCache()
    }
    
    public func clearCacheEntries(since date: Date) {
        imageCacher.clearCacheEntries(since: date)
    }
    
    public func prefetchAndCacheImages(at urls: [URL]) {
        urls.forEach { prefetchAndCacheImage(at: $0) }
    }
    
    public func prefetchAndCacheImage(at url: URL) {
        Task { try await downloadAndCacheImage(for: url) }
    }
    
    public func removeImageFromCache(at url: URL) {
        imageCacher.removeResponse(at: url)
    }
    
    func getImage(for url: URL) async throws -> Data {
        guard let cacheResult = imageCacher.getResponse(url) else {
            return try await downloadAndCacheImage(for: url)
        }
        return cacheResult.data
    }
    
    @discardableResult private func downloadAndCacheImage(for url: URL) async throws -> Data {
        let response = try await imageDownloader.downloadImage(url: url)
        imageCacher.cacheResponse(response.0, request: response.1)
        return response.0.data
    }
}
