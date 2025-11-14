import Foundation

/// A protocol that represents any Markdown inline content.
public protocol InlineContentProtocol {
  var _inlineContent: InlineContent { get }
}

/// A Markdown inline content value.
///
/// A Markdown inline content value represents the inline text inside a leaf Markdown block,
/// like a paragraph, heading, or table cell. Some inline elements, like emphasized or strong
/// text, can contain other inlines, allowing a piece of text to have multiple styles
/// simultaneously.
///
/// You don't use this type directly to create Markdown inline content. Instead, you create
/// inline content by composing specific inline instances inside a closure annotated with
/// the `@InlineContentBuilder` attribute. Types like ``Paragraph``,
/// ``Heading`` or ``TextTableColumn`` provide initializers for composing
/// inline content.
///
/// The following example shows how you can create a paragraph by composing inline
/// content.
///
/// ```swift
/// Markdown {
///   Paragraph {
///     "You can try "
///     Strong("CommonMark")
///     SoftBreak()
///     InlineLink("here", destination: URL(string: "https://spec.commonmark.org/dingus/")!)
///     "."
///   }
/// }
/// ```
public struct InlineContent: Equatable, InlineContentProtocol {
  public var _inlineContent: InlineContent { self }
  
  /// The inline elements that form this inline content.
  ///
  /// You can use this property to inspect, filter, or modify the inline structure
  /// of text within blocks.
  ///
  /// ```swift
  /// let paragraph = Paragraph {
  ///   "Visit "
  ///   InlineLink("our site", destination: URL(string: "https://example.com")!)
  /// }
  /// let inlines = paragraph._markdownContent.blocks.first?.inlineContent
  /// ```
  public let inlines: [InlineNode]

  /// Creates inline content from an array of inline elements.
  ///
  /// Use this initializer to construct inline content from inline nodes you've
  /// created or modified programmatically.
  ///
  /// - Parameter inlines: The inline elements to include in the content.
  public init(inlines: [InlineNode] = []) {
    self.inlines = inlines
  }

  init(_ components: [InlineContentProtocol]) {
    self.init(inlines: components.map(\._inlineContent).flatMap(\.inlines))
  }

  init(_ text: String) {
    self.init(inlines: [.text(text)])
  }
}
