import SwiftUI

public extension View {
    func materialOverlay<Overlay: View>(
        @ViewBuilder overlay: @escaping () -> Overlay
    ) -> some View {
        modifier(MaterialOverlay(overlay: overlay))
    }
    
    func blurOverlay<Overlay: View>(
        @ViewBuilder overlay: @escaping () -> Overlay
    ) -> some View {
        modifier(BlurOverlay(overlay: overlay))
    }
}

private enum Constants {
    static let additionalPadding: CGFloat = 20
    static let blurRadius: CGFloat = 12
    static let scaleValue: CGFloat = 1.045
}

private struct BlurOverlay<Overlay: View>: ViewModifier {
    let overlay: () -> Overlay
    @State private var height: CGFloat = 300
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
                .overlay {
                    content
                        .allowsHitTesting(false)
                        .blur(radius: Constants.blurRadius)
                        .scaleEffect(Constants.scaleValue)
                        .mask {
                            VStack {
                                Spacer()
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
                                .frame(height: height + Constants.additionalPadding)
                            }
                        }
                }
            
            
            overlay()
                .onGeometryChange(for: CGSize.self) { geometry in
                    geometry.size
                } action: { newValue in
                    height = newValue.height
                }
        }
    }
}

private struct MaterialOverlay<Overlay: View>: ViewModifier {
    let overlay: () -> Overlay
    @State private var height: CGFloat = 300
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .allowsHitTesting(false)
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
