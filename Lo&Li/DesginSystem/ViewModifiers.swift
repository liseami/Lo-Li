//
//  ViewMod.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI

/**
 调整按钮位置至屏幕角落
 */

public struct PF_MovotoModifier: ViewModifier {
    public enum edge {
        case centerLeading
        case centerTrailing
        case topCenter
        case bottomCenter
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }

    var WhereMoveTo: edge
    public func body(content: Content) -> some View {
        switch WhereMoveTo {
        case .centerLeading:
            HStack(alignment: .center) { content; Spacer() }
        case .centerTrailing:
            HStack(alignment: .center) { Spacer(); content }
        case .topCenter:
            VStack { content; Spacer() }
        case .bottomCenter:
            VStack { Spacer(); content }
        case .topLeading:
            VStack { HStack { content; Spacer() }; Spacer() }
        case .topTrailing:
            VStack { HStack { Spacer(); content }; Spacer() }
        case .bottomLeading:
            VStack { Spacer(); HStack { content; Spacer() }}
        case .bottomTrailing:
            VStack { Spacer(); HStack { Spacer(); content }}
        }
    }
}

extension View {
    func MoveTo(_ edge: PF_MovotoModifier.edge) -> some View {
        modifier(PF_MovotoModifier(WhereMoveTo: edge))
    }
}

extension View {
    func NaduoShadow(color: Color = .black, style: NaduoShadowModifier.Style = .s800) -> some View {
        modifier(NaduoShadowModifier(color: color, style: style))
    }
}

/**
 阴影
  */
public struct NaduoShadowModifier: ViewModifier {
    let color: Color
    var style: Style = .s100
    public enum Style {
        case s100, s200, s300, s400, s500, s600, s700, s800
    }

    public func body(content: Content) -> some View {
        switch style {
        case .s100:
            content
                .shadow(color: color.opacity(0.12), radius: 4, x: 0, y: 2)
                .shadow(color: color.opacity(0.08), radius: 4, x: 0, y: 4)
        case .s200:
            content
                .shadow(color: color.opacity(0.12), radius: 6, x: 0, y: 4)
                .shadow(color: color.opacity(0.08), radius: 8, x: 0, y: 8)
        case .s300:
            content
                .shadow(color: color.opacity(0.12), radius: 8, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 16, x: 0, y: 8)
        case .s400:
            content
                .shadow(color: color.opacity(0.12), radius: 12, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 24, x: 0, y: 8)
        case .s500:
            content
                .shadow(color: color.opacity(0.12), radius: 14, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 32, x: 0, y: 10)
        case .s600:
            content
                .shadow(color: color.opacity(0.12), radius: 18, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 42, x: 0, y: 12)
        case .s700:
            content
                .shadow(color: color.opacity(0.12), radius: 22, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 64, x: 0, y: 14)
        case .s800:
            content
                .shadow(color: color.opacity(0.12), radius: 22, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 88, x: 0, y: 18)
        }
    }
}

/**
 SheetCard
  */
extension View {
    func isSheetCard() -> some View {
        modifier(SheetCard())
    }
}

struct SheetCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 16)
            .background(Color.b1.opacity(0.98))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .NaduoShadow(color: .f1.opacity(0.8), style: .s200)
            .padding(.all, 12)
    }
}

struct SheetLine: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 12)
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: 1).foregroundColor(.l1))
    }
}

/**
 TostaCard
  */
extension View {
    func isTostaCard() -> some View {
        modifier(TostaCard())
    }
}

struct TostaCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 12)
            .background(Color.b1.opacity(0.98))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .NaduoShadow(color: .f1.opacity(0.8), style: .s200)
            .NaduoShadow(color: .f1.opacity(0.6), style: .s700)
            .padding(.all, SCREEN_WIDTH * ((1 - 0.618) * 0.618 / 2))
    }
}

/**
 Tag
  */
struct TagInCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(Color.b2.opacity(0.6)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)))
    }
}

extension View {
    func isTagInCard() -> some View {
        modifier(TagInCard())
    }
}

/**
 添加边框
  */
struct ViewStroke: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 12)
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: 1).foregroundColor(.l1))
    }
}

extension View {
    func addViewStroke() -> some View {
        modifier(ViewStroke())
    }
}

/**
 滑动选中
 */
extension View {
    func addSelectedGesture(selected: Bool, canbetap: Bool, selectedAction: @escaping () -> ()) -> some View {
        modifier(SelectedGesture(selected: selected, canbetap: canbetap, selectedAction: selectedAction))
    }
}

struct SelectedGesture: ViewModifier {
    var selected: Bool
    var canbetap: Bool
    var cornerRadius: CGFloat
    var selectedAction: () -> ()
    init(selected: Bool, canbetap: Bool, cornerRadius: CGFloat = 12, selectedAction: @escaping () -> ()) {
        self.selected = selected
        self.canbetap = canbetap
        self.cornerRadius = cornerRadius
        self.selectedAction = selectedAction
    }

    @GestureState var dragOffsetX: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.blue)
                    .ifshow(selected))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color.blue.opacity(0.1)).ifshow(selected), alignment: .center)
            .offset(x: dragOffsetX)
            .animation(.NaduoSpring, value: dragOffsetX)
            .gesture(gesture)
            .onTapGesture {
                guard canbetap else { return }
                selectedAction()
            }
    }

    var gesture: _EndedGesture<GestureStateGesture<DragGesture, CGFloat>> {
        DragGesture(minimumDistance: 24, coordinateSpace: .global)
            .updating($dragOffsetX) { value, out, _ in
                let xmove = value.translation.width
                out = xmove
            }
            .onEnded { value in
                let x = abs(value.translation.width)
                if x >= 66 {
                    mada(.impact(.rigid))
                    selectedAction()
                }
            }
    }
}

/**
 文字标签
 */
extension View {
    func isTextTag(_ color: Color = .black) -> some View {
        modifier(TextTagViewModifier(color))
    }
}

struct TextTagViewModifier: ViewModifier {
    let color: Color
    init(_ color: Color = .MainColor) {
        self.color = color
    }

    func body(content: Content) -> some View {
        content
            .ndFont(.body2b, color: color)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

/**
 快捷添加背景色、裁剪角度、边线
 */
struct BackgroundWithCornerRadiusAndStroke: ViewModifier {
    var cornerRadius: CGFloat
    var backGroundColor: Color
    var strokeLineWidth: CGFloat
    var strokeFColor: Color

    init(cornerRadius: CGFloat = 12, backGroundColor: Color = .white, strokeLineWidth: CGFloat = 1, strokeFColor: Color = .clear) {
        self.cornerRadius = cornerRadius
        self.backGroundColor = backGroundColor
        self.strokeLineWidth = strokeLineWidth
        self.strokeFColor = strokeFColor
    }

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        return content
            .background(backGroundColor)
            .clipShape(shape)
            .overlay(alignment: .center) {
                shape.stroke(lineWidth: strokeLineWidth)
                    .foregroundColor(strokeFColor)
            }
    }
}

extension View {
    func addBack(cornerRadius: CGFloat = 12, backGroundColor: Color = .white, strokeLineWidth: CGFloat = 1, strokeFColor: Color = .clear) -> some View {
        modifier(BackgroundWithCornerRadiusAndStroke(cornerRadius: cornerRadius, backGroundColor: backGroundColor, strokeLineWidth: strokeLineWidth, strokeFColor: strokeFColor))
    }
}

/**
 视图触摸回调
 */
struct OnTouch: ViewModifier {
    var onTouch: () -> ()
    init(onTouch: @escaping () -> ()) {
        self.onTouch = onTouch
    }

    func body(content: Content) -> some View {
        let gusture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                withAnimation(.NaduoSpring) {
                    onTouch()
                }
            }
        content
            .gesture(gusture)
    }
}

extension View {
    func onTouch(onTouch: @escaping () -> ()) -> some View {
        modifier(OnTouch(onTouch: onTouch))
    }
}

/**
 黄金边距
 */
struct GoldenPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 16 * 0.618)
    }
}

extension View {
    func addGoldenPadding() -> some View {
        modifier(GoldenPadding())
    }
}

/**
 FantasyLabel，性感的标签
 */
struct isFantasyLabelViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .addGoldenPadding()
            .addBack(cornerRadius: 12, backGroundColor: .b1, strokeLineWidth: 0.6, strokeFColor: .b2)
    }
}

extension View {
    func isFantasyLabel() -> some View {
        modifier(isFantasyLabelViewModifier())
    }
}

/**
 isFantasyTextField 性感的输入框
 */
struct isFantasyTextFieldViewModifier: ViewModifier {
    var color: Color
    init(color: Color = .yellow) {
        self.color = color
    }

    func body(content: Content) -> some View {
        content
            .frame(height: 32)
            .ndFont(.body1, color: .f1)
            .addGoldenPadding()
            .addBack(cornerRadius: 9, backGroundColor: color, strokeLineWidth: 0.6, strokeFColor: color.opacity(0.6))
    }
}

extension View {
    func isFantasyTextField(color: Color = .yellow) -> some View {
        modifier(isFantasyTextFieldViewModifier(color: color))
    }
}

/**
 Placeholder...
 */

struct isFantasyPlaceHolderViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 100)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

extension View {
    func isFantasyPlaceHolder() -> some View {
        modifier(isFantasyPlaceHolderViewModifier())
    }
}

/*
 Image in Post ...
 */

struct PostImageAreaViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .addBack(cornerRadius: 12, backGroundColor: .clear, strokeLineWidth: 0.6, strokeFColor: .b3)
    }
}

extension View {
    func isPostImageArea() -> some View {
        modifier(PostImageAreaViewModifier())
    }
}

struct SearchBtnModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .submitLabel(.search)
            .PF_Leading()
            .frame(height: 28)
            .addGoldenPadding()
            .addBack(cornerRadius: 15, backGroundColor: .b1, strokeLineWidth: 1.2, strokeFColor: .b2)
    }
}

extension View {
    func isSearchBtn() -> some View {
        modifier(SearchBtnModifier())
    }
}

/*
 LoadingBlur
 */

struct LoadingBlurLayer: ViewModifier {
    var loading: Bool
    func body(content: Content) -> some View {
        content
            .overlay(Color.white.opacity(0.01).ignoresSafeArea().ifshow(loading))
            .blur(radius: loading ? 7 : 0)
            .overlay(ProgressView().ifshow(loading))
    }
}

extension View {
    func addLoadingBlurLayer(loading: Bool) -> some View {
        modifier(LoadingBlurLayer(loading: loading))
    }
}

/*
 可选择视图..
 */

extension View {
    ///
    /// - Parameters:
    ///   - arr: 选择arr
    ///   - value: 当前值
    ///   - isEditMod: 编辑模式
    func canBeSelected<Value>(arr: Binding<[Value]>, value: Value, isEditMod: Bool) -> some View where Value: Hashable {
        modifier(CanBeSelected(arr: arr, value: value, isEditMod: isEditMod))
    }
}

struct CanBeSelected<Value>: ViewModifier where Value: Hashable {
    @Binding var arr: [Value]
    var value: Value
    var isEditMod: Bool

    init(arr: Binding<[Value]>, value: Value, isEditMod: Bool) {
        self._arr = arr
        self.value = value
        self.isEditMod = isEditMod
    }

    func body(content: Content) -> some View {
        if isEditMod {
            let selected = arr.contains(value)
            Button {
                withAnimation(.spring()) {
                    if selected {
                        arr.removeAll(value)
                    } else {
                        arr.append(value)
                    }
                }
            } label: {
                HStack {
                    Circle()
                        .stroke(lineWidth: 1).foregroundColor(selected ? .MainColor.opacity(0.5) : .b3)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Circle().foregroundColor(.MainColor)
                                .frame(width: 20, height: 20)
                                .transition(.opacity.combined(with: .scale))
                                .ifshow(selected)
                        }
                    content.disabled(true)
                }
                .padding(.leading, 12)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        } else {
            content
        }
    }
}

struct ShimmeringView<Content: View>: View {
    private let content: () -> Content
    private let configuration: ShimmerConfiguration
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    init(configuration: ShimmerConfiguration, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        _startPoint = .init(wrappedValue: configuration.initialLocation.start)
        _endPoint = .init(wrappedValue: configuration.initialLocation.end)
    }

    var body: some View {
        content()
            .overlay(
                LinearGradient(
                    gradient: configuration.gradient,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                .opacity(configuration.opacity)
                .blendMode(.screen)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                            startPoint = configuration.finalLocation.start
                            endPoint = configuration.finalLocation.end
                        }
                    }
                })
            )
    }
}

public struct ShimmerModifier: ViewModifier {
    let configuration: ShimmerConfiguration
    public func body(content: Content) -> some View {
        ShimmeringView(configuration: configuration) { content }
    }
}

public class ShimmerConfiguration {
    var gradient: Gradient
    var initialLocation: (start: UnitPoint, end: UnitPoint)
    var finalLocation: (start: UnitPoint, end: UnitPoint)
    var duration: TimeInterval
    var opacity: Double
    init(gradient: Gradient, initialLocation: (start: UnitPoint, end: UnitPoint), finalLocation: (start: UnitPoint, end: UnitPoint), duration: TimeInterval, opacity: Double) {
        self.gradient = gradient
        self.initialLocation = initialLocation
        self.finalLocation = finalLocation
        self.duration = duration
        self.opacity = opacity
    }
}

public extension View {
    func shimmer() -> some View {
        let c = ShimmerConfiguration(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .white, location: 0.3),
                .init(color: .white, location: 0.7),
                .init(color: .black, location: 1),
            ]),
            initialLocation: (start: UnitPoint(x: -1, y: 0.5), end: .leading),
            finalLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
            duration: 0.7,
            opacity: 0.5
        )
        return modifier(ShimmerModifier(configuration: c))
    }
}

struct ViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}

/*
 云朵Sheet
 */

struct CloudSheet: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            pageBackGround
            VStack(spacing: 32) {
                Capsule(style: .continuous)
                    .frame(width: 32, height: 4, alignment: .center)
                    .foregroundColor(.f2)
                    .padding(.top, 12)
                content
            }
        }
        .clipShape(RoundedCorner(radius: 32, corners: [.topLeft, .topRight]), style: .init())
        .ignoresSafeArea()
        .padding(.top, 12)
        .NaduoShadow(color: .f1, style: .s200)
    }

    @ViewBuilder
    var pageBackGround: some View {
        Color.white
            .opacity(0.89)
            .ignoresSafeArea()
        BlurView(colorSheme: .extraLight).ignoresSafeArea()
    }
}

extension View {
    func isCloudSheet() -> some View {
        modifier(CloudSheet())
    }
}

/*
 返回按钮+页面标题
 */
struct AddBackBtn: ViewModifier {
    let title: String
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 0) {
                        ICON(name: "chevrondown", fcolor: .f2)
                            .rotationEffect(.init(degrees: 90))
                            .offset(x: 0, y: 4)
                        Text(title)
                            .ndFont(.t2b, color: .f1)
                    }
                    .onTapGesture {
                        PageBack()
                    }
                }
            }
    }
}

extension View {
    func addBackBtn(title: String = "") -> some View {
        modifier(AddBackBtn(title: title))
    }
}

/*
 Naduo公共边距 = padding(.all,18)
 */
struct NaduoPadding: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(.horizontal, .Naduo.padding18)
            .padding(.vertical, .Naduo.padding18 * 0.618)
    }
}

extension View {
    func naduoPadding() -> some View {
        modifier(NaduoPadding())
    }
}

/*
 获取视图当前的移动距离
 */

struct ViewOffsetViewModifier: ViewModifier {
    let direction: Edge.Set
    let onViewOffsetChange: (CGFloat) -> ()
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader(content: { GeometryProxy in
                    let value = self.direction == .vertical ?
                        GeometryProxy.frame(in: .global).minY :
                        GeometryProxy.frame(in: .global).minX
                    Color.clear.preference(key: ViewOffsetKey.self, value: value)
                }))
            // 向Vm上报，inputbar的MinY...
            .onPreferenceChange(ViewOffsetKey.self) {
                print(" >> \($0)")
                onViewOffsetChange($0)
            }
    }
}

extension View {
    func getViewOffset(direction: Edge.Set = .vertical, onViewOffsetChange: @escaping (CGFloat) -> ()) -> some View {
        modifier(ViewOffsetViewModifier(direction: direction, onViewOffsetChange: onViewOffsetChange))
    }
}

struct LoliCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .addBack(cornerRadius: 24, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
            .NaduoShadow(color: .f2, style: .s300)
            .NaduoShadow(color: .f3, style: .s100)
            .padding(.all, 6)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(Color.teal.opacity(0.1).gradient)
            }
    }
}

extension View {
    func addLoliCardBack() -> some View {
        modifier(LoliCardModifier())
    }
}


struct LoliBtnModifier : ViewModifier {
    func body(content: Content) -> some View {
         content
            .addBack(cornerRadius: 10, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
            .NaduoShadow(color: .f2, style: .s300)
            .NaduoShadow(color: .f3, style: .s100)
            .padding(.all, 3)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(lineWidth: 1.5)
                    .fill(Color.f2.opacity(0.3).gradient)
            }
            .padding(.all, 3)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(lineWidth: 4)
                    .fill(Color.f3.opacity(0.3).gradient)
            }
    }
}



extension View {
    func addLoliBtnBack() -> some View {
        self.modifier(LoliBtnModifier())
    }
}
