import Foundation

/**
 * This extension adds predifined values of spacing.
 *
 * The constants defined here should be used for spacing,
 * inset, padding and margin definitions as much as possible.
 * Extending `ExpressibleByIntegerLiteral` adds these constants
 * to all types that can be initialized with an integer, such as `Int`, `Double` or `CGFLoat`.
 */
extension ExpressibleByIntegerLiteral {

    /// Represents empty space with size of 16 pt
    public static var spacingMedium: Self { 16 }

}
