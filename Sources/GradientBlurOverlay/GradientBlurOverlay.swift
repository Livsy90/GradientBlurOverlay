import SwiftUI

public extension View {
    func gradientBlurOverlay<Overlay: View>(
        @ViewBuilder overlay: @escaping () -> Overlay
    ) -> some View {
        modifier(BlurredOverlay(overlay: overlay))
    }
}

private struct BlurredOverlay<Overlay: View>: ViewModifier {
    let overlay: () -> Overlay
    @State private var height: CGFloat = 300
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask {
                    LinearGradient(
                        colors: [
                            .clear,
                            .black.opacity(0.1),
                            .black.opacity(0.7),
                            .black.opacity(0.9),
                            .black,
                            .black,
                            .black,
                            .black
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .frame(height: height)
            
            overlay()
                .onGeometryChange(for: CGSize.self) { geometry in
                    geometry.size
                } action: { newValue in
                    height = newValue.height
                }
        }
    }
}
