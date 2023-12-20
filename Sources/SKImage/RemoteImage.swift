import SwiftUI

struct RemoteImage: View {
    private let url: URL
    private let width: CGFloat?
    private let height: CGFloat?
    private let contentMode: ContentMode
    private let cornerRadius: CGFloat
    
    @State private var isLoading = false
    @State private var imageData: Data?
    
    var body: some View {
        ZStack {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height)
                    .clipShape(.rect(cornerRadius: cornerRadius))
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            isLoading = true
            do {
                let result = try await SKImageConfig.shared.getImage(for: url)
                imageData = result
                isLoading = false
            } catch  {
                isLoading = false
            }
        }
    }
    
    init(
        url: URL,
        width: CGFloat?,
        height: CGFloat?,
        contentMode: ContentMode = .fill,
        cornerRadius: CGFloat
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }
}
