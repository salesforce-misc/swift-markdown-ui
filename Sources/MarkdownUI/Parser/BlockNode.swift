import Foundation

/// Represents a block-level Markdown element.
///
/// Block elements are the structural components of a Markdown document, such as
/// paragraphs, headings, lists, blockquotes, code blocks, and tables.
///
/// You can use this type to inspect and manipulate the structure of parsed Markdown content.
///
/// ```swift
/// let content = MarkdownContent("# Title\n\nParagraph text")
/// for block in content.blocks {
///   switch block {
///   case .heading(let level, let inlines):
///     print("Heading level \(level)")
///   case .paragraph(let inlines):
///     print("Paragraph with \(inlines.count) inline elements")
///   default:
///     break
///   }
/// }
/// ```
public enum BlockNode: Hashable {
  /// A blockquote containing child block elements.
  case blockquote(children: [BlockNode])
  /// An unordered (bulleted) list with items.
  case bulletedList(isTight: Bool, items: [RawListItem])
  /// An ordered (numbered) list with a starting number and items.
  case numberedList(isTight: Bool, start: Int, items: [RawListItem])
  /// A task list with checkable items.
  case taskList(isTight: Bool, items: [RawTaskListItem])
  /// A code block with optional language identifier.
  case codeBlock(fenceInfo: String?, content: String)
  /// Raw HTML block content.
  case htmlBlock(content: String)
  /// A paragraph containing inline elements.
  case paragraph(content: [InlineNode])
  /// A heading with a level (1-6) and inline content.
  case heading(level: Int, content: [InlineNode])
  /// A table with column alignments and rows.
  case table(columnAlignments: [RawTableColumnAlignment], rows: [RawTableRow])
  /// A thematic break (horizontal rule).
  case thematicBreak
}

extension BlockNode {
  /// Returns the child block nodes for container elements.
  ///
  /// For container elements like blockquotes and lists, this property returns their
  /// child blocks. For leaf blocks like paragraphs and headings, it returns an empty array.
  public var children: [BlockNode] {
    switch self {
    case .blockquote(let children):
      return children
    case .bulletedList(_, let items):
      return items.map(\.children).flatMap { $0 }
    case .numberedList(_, _, let items):
      return items.map(\.children).flatMap { $0 }
    case .taskList(_, let items):
      return items.map(\.children).flatMap { $0 }
    default:
      return []
    }
  }

  /// Returns `true` if this block is a paragraph.
  public var isParagraph: Bool {
    guard case .paragraph = self else { return false }
    return true
  }
}

/// Represents an item in a bulleted or numbered list.
public struct RawListItem: Hashable {
  /// The block elements contained in this list item.
  public let children: [BlockNode]
  
  /// Creates a list item with the specified child blocks.
  public init(children: [BlockNode]) {
    self.children = children
  }
}

/// Represents an item in a task list.
public struct RawTaskListItem: Hashable {
  /// Whether the task is marked as completed.
  public let isCompleted: Bool
  /// The block elements contained in this task list item.
  public let children: [BlockNode]
  
  /// Creates a task list item with the specified completion state and child blocks.
  public init(isCompleted: Bool, children: [BlockNode]) {
    self.isCompleted = isCompleted
    self.children = children
  }
}

/// The alignment of a table column.
public enum RawTableColumnAlignment: Character {
  /// No specific alignment.
  case none = "\0"
  /// Left-aligned.
  case left = "l"
  /// Center-aligned.
  case center = "c"
  /// Right-aligned.
  case right = "r"
}

/// Represents a row in a Markdown table.
public struct RawTableRow: Hashable {
  /// The cells in this row.
  public let cells: [RawTableCell]
  
  /// Creates a table row with the specified cells.
  public init(cells: [RawTableCell]) {
    self.cells = cells
  }
}

/// Represents a cell in a Markdown table.
public struct RawTableCell: Hashable {
  /// The inline content of this cell.
  public let content: [InlineNode]
  
  /// Creates a table cell with the specified inline content.
  public init(content: [InlineNode]) {
    self.content = content
  }
}
