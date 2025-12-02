//
//  Previewable.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

/// Protocol that views can conform to for automatic preview generation
protocol Previewable: View {
    /// The preview name (optional, defaults to view type name)
    static var previewName: String { get }
    
    /// Whether to wrap the preview in a NavigationView (defaults to true)
    static var previewWrappedInNavigation: Bool { get }
    
    /// Required initializer for preview generation
    init()
}

extension Previewable {
    /// Default preview name is the type name
    static var previewName: String {
        String(describing: Self.self)
    }
    
    /// Default is to wrap in NavigationView
    static var previewWrappedInNavigation: Bool {
        true
    }
    
    /// Generate preview view
    @ViewBuilder
    static func previewContent() -> some View {
        if previewWrappedInNavigation {
            NavigationView {
                Self()
            }
        } else {
            Self()
        }
    }
}

/// Extension to make it easier to add previews
extension View {
    /// Wraps the view in a NavigationView for preview
    func previewInNavigation() -> some View {
        NavigationView {
            self
        }
    }
}

