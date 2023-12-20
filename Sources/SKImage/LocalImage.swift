import SwiftUI

struct LocalImage: View {
    private let name: String
    private let width: CGFloat?
    private let height: CGFloat?
    private let contentMode: ContentMode
    private let cornerRadius: CGFloat
    
    var body: some View {
        Image(name)
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: cornerRadius))
    }
    
    init(
        name: String,
        width: CGFloat?,
        height: CGFloat?,
        contentMode: ContentMode = .fill,
        cornerRadius: CGFloat
    ) {
        self.name = name
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }
}
