// SPM build (`canImport(NetworkImageView)` is true) uses the vendored
// NetworkImageView module — required so MarkdownUI's emitted
// .swiftinterface qualifies type references via `NetworkImageView.X`
// rather than `NetworkImage.X`, sidestepping the Swift compiler bug
// where the leading `NetworkImage` resolves to the inner struct rather
// than the module under BUILD_LIBRARY_FOR_DISTRIBUTION=YES.
//
// CocoaPods build (NetworkImageView is not a pod) falls through to
// the upstream NetworkImage pod. CocoaPods does not enable library
// evolution, so the swiftinterface bug does not manifest there.
#if canImport(NetworkImageView)
@_implementationOnly import NetworkImageView
#else
@_implementationOnly import NetworkImage
#endif
import SwiftUI

/// The default image provider, which loads images from the network.
public struct DefaultImageProvider: ImageProvider {
  public func makeImage(url: URL?) -> some View {
    NetworkImage(url: url) { state in
      switch state {
      case .empty, .failure:
        Color.clear
          .frame(width: 0, height: 0)
      case .success(let image, let idealSize):
        ResizeToFit(idealSize: idealSize) {
          image.resizable()
        }
      }
    }
  }
}

extension ImageProvider where Self == DefaultImageProvider {
  /// The default image provider, which loads images from the network.
  ///
  /// Use the `markdownImageProvider(_:)` modifier to configure this image provider for a view hierarchy.
  public static var `default`: Self {
    .init()
  }
}
