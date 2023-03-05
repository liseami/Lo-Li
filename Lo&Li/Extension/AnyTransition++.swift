//
//  AnyTransition++.swift
//  Looper
//
//  Created by 赵翔宇 on 2022/6/21.
//

import SwiftUI

struct thing {
    var id = UUID()
}

struct TestView: View {
    @State private var things: [thing] = []
    var body: some View {
        ScrollView {
            VStack {
                Text("""
                myView
                .transition(.dropInHole)
                .ifshow(show)
                """)
                .PF_Leading()
                .padding()
                .background(Color.gray.opacity(0.1).clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous)))

                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.things.append(.init())
                        }
                    } label: {
                        ICON(sysname: "plus"){
                            ChatConversation(context: PersistenceController.shared.container.viewContext)
                                .addNew()
                        }
                    }
                    Button {
                        withAnimation(.default) {
                            things = things.dropLast()
                        }

                    } label: {
                        ICON(sysname: "minus")
                    }
                }

                let blocksize = SCREEN_WIDTH * 0.45
                let spacing = SCREEN_WIDTH * 0.1/3
                let columns = Array(repeating: GridItem(.fixed(blocksize), spacing: spacing, alignment: .center), count: 2)

                LazyVGrid(columns: columns, alignment: .center, spacing: spacing, content: {
                    ForEach(things, id: \.self.id) { _ in
                        Color.blue.frame(width: blocksize, height: blocksize)
                            .transition(.PFTransition)
                    }

                })
            }
            .padding()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct CountUpEffect: AnimatableModifier {
    func body(content: Content) -> some View {
        content
    }
}

public extension AnyTransition {
    // 消失术
    static var disappear: AnyTransition {
        struct disappearLottie: ViewModifier {
            var animationProgress: CGFloat = 0
            func body(content: Content) -> some View {
                Group {
                    if animationProgress == 0 {
                        content
                            .rotation3DEffect(Angle(degrees: 20), axis: (x: animationProgress, y: animationProgress, z: animationProgress))
                    } else {
                        AutoLottieView(lottieFliesName: "disappear", loopMode: .playOnce)
                            .frame(width: 88, height: 88)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
        }
        let a = AnyTransition.modifier(active: disappearLottie(animationProgress: 1), identity: disappearLottie(animationProgress: 0))
        return a
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension AnyTransition {
    /// Fade-in transition
    static var fade: AnyTransition {
        let insertion = AnyTransition.opacity
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Fade-in transition with duration
    /// - Parameter duration: transition duration, use ease-in-out
    /// - Returns: A transition with duration
    static func fade(duration: Double) -> AnyTransition {
        let insertion = AnyTransition.opacity.animation(.easeInOut(duration: duration))
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from left transition
    static var flipFromLeft: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from left transition with duration
    /// - Parameter duration: transition duration, use ease-in-out
    /// - Returns: A transition with duration
    static func flipFromLeft(duration: Double) -> AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).animation(.easeInOut(duration: duration))
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from right transition
    static var flipFromRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from right transition with duration
    /// - Parameter duration: transition duration, use ease-in-out
    /// - Returns: A transition with duration
    static func flipFromRight(duration: Double) -> AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).animation(.easeInOut(duration: duration))
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from top transition
    static var flipFromTop: AnyTransition {
        let insertion = AnyTransition.move(edge: .top)
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from top transition with duration
    /// - Parameter duration: transition duration, use ease-in-out
    /// - Returns: A transition with duration
    static func flipFromTop(duration: Double) -> AnyTransition {
        let insertion = AnyTransition.move(edge: .top).animation(.easeInOut(duration: duration))
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from bottom transition
    static var flipFromBottom: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    /// Flip from bottom transition with duration
    /// - Parameter duration: transition duration, use ease-in-out
    /// - Returns: A transition with duration
    static func flipFromBottom(duration: Double) -> AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom).animation(.easeInOut(duration: duration))
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

    static let PFTransition: AnyTransition = .scale.combined(with: .opacity).combined(with: .fade)
}

extension AnyTransition {
    static var fly: AnyTransition {
        AnyTransition.modifier(active: FlyTransition(pct: 0), identity: FlyTransition(pct: 1))
    }
}

struct FlyTransition: GeometryEffect {
    var pct: Double

    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let rotationPercent = pct
        let a = CGFloat(Angle(degrees: 90 * (1 - rotationPercent)).radians)

        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)

        transform3d = CATransform3DRotate(transform3d, a, 1, 0, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

        let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0))
        let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(pct * 2), y: CGFloat(pct * 2)))

        if pct <= 0.5 {
            return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
        } else {
            return ProjectionTransform(transform3d).concatenating(affineTransform1)
        }
    }
}

public extension AnyTransition {
    static func cardTransition(size: CGSize) -> AnyTransition {
        let insertion = AnyTransition.offset(flyFrom(for: size))
        let removal = AnyTransition.offset(flyTo(for: size))
            .combined(with: AnyTransition.scale(scale: 0.5))

        return .asymmetric(insertion: insertion, removal: removal)
    }

    static func flyFrom(for size: CGSize) -> CGSize {
        CGSize(width: 0.0 /* CGFloat.random(in: -size.width/2...size.width/2) */,
               height: 2 * size.height)
    }

    static func flyTo(for size: CGSize) -> CGSize {
        CGSize(width: CGFloat.random(in: -3 * size.width...3 * size.width),
               height: CGFloat.random(in: -2 * size.height...(-size.height)))
    }
}

public struct AnyShape: Shape {
    private var base: (CGRect) -> Path

    public init<S: Shape>(shape: S) {
        base = shape.path(in:)
    }

    public func path(in rect: CGRect) -> Path {
        base(rect)
    }
}
