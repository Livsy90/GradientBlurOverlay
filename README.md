# Gradient Blurred Overlay for SwiftUI

Adds a bottom blurred overlay with a smooth gradient transition for any SwiftUI view.

## Installation

### Using Swift Package Manager (recommended)

1. In Xcode, go to **File > Add Package Dependencies…**  
2. Enter the repository URL:  

```
https://github.com/Livsy90/GradientBlurOverlay
```

3. Select a version rule (commonly **Up to Next Major**).  
4. Add the product **GradientBlurOverlay** to your app target.  
5. In the files where you use the modifier, add:  
```swift
import GradientBlurOverlay
```

Requirements:

	•	iOS 16.0+ 
 
Usage

Use the gradientBlurdOverlay view modifier to add a dynamic blurred overlay to any view. For example:

```
import SwiftUI

struct MyView: View {
    var body: some View {
        Image(.berries)
            .resizable()
            .scaledToFit()
            .gradientBlurOverlay {
                VStack {
                    Text("Title")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Text("Subtitle")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, 40)
            }
            .clipShape(.rect(cornerRadius: 30))
            .padding()
    }
}

#Preview {
    MyView()
}
```

The blur adapts dynamically to the height of the overlay, ensuring a seamless gradient effect that matches your content.
