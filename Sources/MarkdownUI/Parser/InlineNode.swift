import Foundation

/// Represents an inline Markdown element.
///
/// Inline elements are the content within block elements like paragraphs and headings.
/// They include text, formatted text (emphasis, strong, strikethrough), links, images,
/// code, and line breaks.
///
/// You can use this type to inspect and manipulate the inline content of parsed Markdown.
///
/// ```swift
/// let content = MarkdownContent("This is **bold** text")
/// if case .paragraph(let inlines) = content.blocks.first {
///   for inline in inlines {
///     switch inline {
///     case .text(let str):
///       print("Text: \(str)")
///     case .strong(let children):
///       print("Strong with \(children.count) children")
///     default:
///       break
///     }
///   }
/// }
/// ```
public enum InlineNode: Hashable, Sendable {
  /// Plain text content.
  case text(String)
  /// A soft line break (typically rendered as a space).
  case softBreak
  /// A hard line break (typically rendered as a newline).
  case lineBreak
  /// Inline code.
  case code(String)
  /// Raw HTML content.
  case html(String)
  /// Emphasized (italic) text containing child inline elements.
  case emphasis(children: [InlineNode])
  /// Strong (bold) text containing child inline elements.
  case strong(children: [InlineNode])
  /// Strikethrough text containing child inline elements.
  case strikethrough(children: [InlineNode])
  /// A hyperlink with a destination URL and child inline elements for the link text.
  case link(destination: String, children: [InlineNode])
  /// An image with a source URL and child inline elements for alt text.
  case image(source: String, children: [InlineNode])
}

extension InlineNode {
  /// Returns the child inline nodes for container elements.
  ///
  /// For elements that can contain other inline nodes (emphasis, strong, strikethrough,
  /// link, and image), this property returns their children. For leaf nodes like text
  /// and breaks, it returns an empty array.
  public var children: [InlineNode] {
    get {
      switch self {
      case .emphasis(let children):
        return children
      case .strong(let children):
        return children
      case .strikethrough(let children):
        return children
      case .link(_, let children):
        return children
      case .image(_, let children):
        return children
      default:
        return []
      }
    }

    set {
      switch self {
      case .emphasis:
        self = .emphasis(children: newValue)
      case .strong:
        self = .strong(children: newValue)
      case .strikethrough:
        self = .strikethrough(children: newValue)
      case .link(let destination, _):
        self = .link(destination: destination, children: newValue)
      case .image(let source, _):
        self = .image(source: source, children: newValue)
      default:
        break
      }
    }
  }
}
