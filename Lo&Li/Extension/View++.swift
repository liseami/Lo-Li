//
//  ViewEx.swift
//  SuperBody
//
//  Created by 赵翔宇 on 2022/2/4.
//

import SwiftUI

extension View {
    func isNavigationSubView() -> some View {
        NavigationView {
            Color.clear
                .PF_Navilink(isPresented: .constant(true)) {
                    self
                }
        }
    }

    func isSheetView() -> some View {
        Color.white
            .PF_Sheet_SystemSheetStyle(isPresented: .constant(true), backColor: .white) {
                self
            }
    }

    func isFullScreenCover() -> some View {
        NavigationView {
            Color.white
                .PF_FullScreen(isPresented: .constant(true), onDismiss: {}, content: {
                    self
                })
        }
    }

    func isPreview(_ type: PreviewType) -> some View {
        switch type {
        case .sheet:
            return AnyView(self.isSheetView())
        case .navisubview:
            return AnyView(self.isNavigationSubView())
        case .fullscreen:
            return AnyView(self.isFullScreenCover())
        }
    }

    func addCoreDataEnvironment_preview() -> some View {
        let preview = PersistenceController.preview
        return self.environment(\.managedObjectContext, preview.container.viewContext)
    }
    



    
}

enum PreviewType {
    case sheet
    case fullscreen
    case navisubview
}

public extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

public extension UIView {
    // This is the function to convert UIView to UIImage
    func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

public extension View {
    func asUiImage() -> UIImage {
        var uiImage = UIImage(systemName: "exclamationmark.triangle.fill")!
        let controller = UIHostingController(rootView: self)
        if let view = controller.view {
            let contentSize = view.intrinsicContentSize
            view.bounds = CGRect(origin: .zero, size: contentSize)
            view.backgroundColor = .clear
            let renderer = UIGraphicsImageRenderer(size: contentSize)
            uiImage = renderer.image { _ in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
        }
        return uiImage
    }
}
