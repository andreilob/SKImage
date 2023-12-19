import SwiftUI

public struct SKImage: View {
    public var body: some View {
        switch imageType {
        case .assets(let name):
            LocalImage(
                name: name,
                width: width,
                height: height,
                contentMode: contentMode,
                cornerRadius: cornerRadius
            )
        case .remote(let url):
            RemoteImage(
                url: url,
                width: width,
                height: height,
                contentMode: contentMode,
                cornerRadius: cornerRadius
            )
        }
    }
    
    private let imageType: ImageType
    private let width: CGFloat?
    private let height: CGFloat?
    private let contentMode: ContentMode
    private let cornerRadius: CGFloat
    
    public init(
        imageType: ImageType,
        width: CGFloat?,
        height: CGFloat?,
        contentMode: ContentMode,
        cornerRadius: CGFloat
    ) {
        self.imageType = imageType
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }
}
