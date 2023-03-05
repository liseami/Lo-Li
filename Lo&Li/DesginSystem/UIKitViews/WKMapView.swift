//
//  WKMapViewR.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/18.
//

import MapKit
import SwiftUI

struct WKMapViewRepresentable: UIViewRepresentable {
    let view = MKMapView(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))

    func makeUIView(context: Context) -> MKMapView {
        view.isPitchEnabled = false
        view.isRotateEnabled = false
        view.showsUserLocation = true
        view.userTrackingMode = .follow
        view.delegate = context.coordinator
        view.register(FantasyChatAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(FantasyChatAnnotation.self))
        return view
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: WKMapViewRepresentable
        init(_ parent: WKMapViewRepresentable) {
            self.parent = parent
        }

//        响应地图位置变化
        func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {}
//        告诉代理地图视图显示的区域即将改变。
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {}

//        告诉代理地图视图的可见区域已更改。
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.addPointToCenter()
        }

//        告诉代理地图视图显示的区域刚刚更改。

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !annotation.isKind(of: MKUserLocation.self) else {
                // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
                return nil
            }
            var annotationView: MKAnnotationView?

            if let annotation = annotation as? FantasyChatAnnotation {
                annotationView = parent.setupFantasyChatAnnotation(for: annotation, on: mapView)
            }
            return annotationView
        }

        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {}
    }

    func addPointToCenter() {
        // 始终在屏幕中心放置
        let ScreenCenterTo2D = view.convert(.init(x: SCREEN_WIDTH * 0.4, y: SCREEN_HEIGHT * 0.5 + 32), toCoordinateFrom: view.superview)
        let centerPlacemark = FantasyChatAnnotation(coordinate: ScreenCenterTo2D)
//        NotificationCenter.default.post(name: Notification.Name.FantasyChatScreenCenterNotificationName, object: ScreenCenterTo2D)
        view.removeAnnotations(view.annotations)
        view.addAnnotation(centerPlacemark)
    }

    // 设置自定义标记...
    private func setupFantasyChatAnnotation(for annotation: FantasyChatAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(FantasyChatAnnotation.self)
        let point = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)

        point.canShowCallout = false
        point.isDraggable = false

        // Provide the annotation view's image.
        let image = UIImage(named: "MapPinGreen")!
        point.image = image
        point.size = .init(width: 24, height: 24 / 89 * 133.12)

        // Offset the flag annotation so that the flag pole rests on the map coordinate.
        let offset = CGPoint(x: image.size.width / 2, y: -(image.size.height / 2))
        point.centerOffset = offset

        return point
    }
}

struct WKMapViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        WKMapViewRepresentable()
    }
}

// 自定义标记视图...
class FantasyChatAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? { didSet { update(for: annotation) } }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        update(for: annotation)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        removeFromSuperview()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        transform = CGAffineTransform(translationX: 0, y: -100)
        alpha = 0
        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9) {
            self.transform = .identity
            self.alpha = 1
        }.startAnimation()
    }

    private func update(for annotation: MKAnnotation?) {
        // do whatever update to the annotation view you want, if any
    }
}

// 自定义数据模型...
class FantasyChatAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = .init()
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
