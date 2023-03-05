//
//  PublicStruct.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/23.
//

// MARK: 自定义圆角

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: 图标

struct ICON: View, Equatable {
    public static func == (lhs: ICON, rhs: ICON) -> Bool {
        lhs.name == rhs.name && lhs.sysname == rhs.sysname && lhs.color == rhs.color
    }

    var sysname: String = ""
    var name: String = ""
    var color: Color = .black
    var size: CGFloat
    var fontWeight: Font.Weight = .regular
    var renderMode: Image.TemplateRenderingMode = .template
    var action: (() -> Void)?

    public init(sysname: String, fcolor: Color = .black, size: CGFloat = 20, fontWeight: Font.Weight = .regular, action: (() -> Void)? = nil) {
        self.sysname = sysname
        color = fcolor
        self.size = size
        self.fontWeight = fontWeight
        self.action = action
    }

    public init(name: String, fcolor: Color = .black, size: CGFloat = 24, renderMode: Image.TemplateRenderingMode = .template, action: (() -> Void)? = nil) {
        self.name = name
        color = fcolor
        self.size = size
        self.action = action
        self.renderMode = renderMode
    }

    public var body: some View {
        Button {
            if let action = action {
                action()
            }
        } label: {
            Group {
                if sysname.isEmpty {
                    Image(name)
                        .resizable()
                        .renderingMode(renderMode)
                        .foregroundColor(color)
                        .scaledToFit()
                        .frame(height: size, alignment: .center)
                } else {
                    Image(systemName: sysname)
                        .renderingMode(.template)
                        .font(Font.system(size: size, weight: fontWeight, design: .rounded))
                        .foregroundColor(color)
                }
            }
        }
        .disabled(action == nil)

    }
}

public enum NaviTopStyle {
    case large
    case inline
    case none
}

// MARK: 一个异步加载的图像

// MARK: MenuBtn

public struct PF_MenuBtn: View {
    let text: String
    let sysname: String?
    let name: String?
    let color: Color
    let action: () -> Void

    public init(text: String, sysname: String, color: Color = .black, action: @escaping () -> Void) {
        self.text = text
        self.sysname = sysname
        self.action = action
        self.color = color
        name = nil
    }

    public init(text: String, name: String, color: Color = .black, action: @escaping () -> Void) {
        self.text = text
        self.name = name
        self.color = color
        self.action = action
        sysname = nil
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(text)

            } icon: {
                ICON(sysname: sysname ?? "", fcolor: color)
                    .ifshow(sysname != nil)
                ICON(name: name ?? "", fcolor: color)
                    .ifshow(name != nil)
            }
        }
        .buttonStyle(PF_MenuBtnButtonStyle())
        .buttonStyle(.plain)
    }

    struct PF_MenuBtnButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            let isPressed = configuration.isPressed
            return configuration.label
                .scaleEffect(isPressed ? 0.99 : 1, anchor: .center)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .frame(width: SCREEN_WIDTH * 0.36, alignment: .leading)
                .addBack(cornerRadius: 12, backGroundColor: isPressed ? .white.opacity(0.1) : .clear, strokeLineWidth: 0, strokeFColor: .clear)
        }
    }
}

// MARK: Alert

public struct PF_alert: View {
    public enum AlertStyle {
        case cancel
        case success
        case wrong
    }

    @Binding var show: Bool
    @GestureState private var offset: CGFloat = 0

    var style: AlertStyle = .cancel
    var text: String = "PF_Alert"
    var color: Color = .black
    var textcolor: Color = .black

    public init(text: String, color: Color, textcolor _: Color = .black, show: Binding<Bool>, style: AlertStyle = .cancel) {
        _show = show
        self.text = text
        self.color = color

        self.style = style
    }

    public var body: some View {
        alertBody
            .onAppear(perform: {
                switch style {
                case .cancel:
                    mada(.impact(.rigid))
                case .success:
                    mada(.impact(.rigid))
                case .wrong:
                    mada(.impact(.rigid))
                }
            })
            .onDisappear(perform: {
                mada(.impact(.rigid))
            })
            .ifshow(show)
            .onChange(of: show) { newValue in
                if newValue { DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    if newValue { show = false }
                }}
            }
    }

    @ViewBuilder

    var alertBody: some View {
        let gesture = DragGesture(minimumDistance: 12, coordinateSpace: .global)
            .updating($offset) { value, out, _ in
                let height = value.translation.height
                out = height
            }
            .onEnded { _ in
                show.toggle()
            }

        HStack(spacing: 12) {
            ICON(sysname: "checkmark.circle.fill", fcolor: color, size: 16, action: {
                show.toggle()
            })
            .ifshow(style == .success)
            ICON(sysname: "exclamationmark.circle.fill", fcolor: color, size: 16, action: {
                show.toggle()
            })
            .ifshow(style == .wrong)
            Text(LocalizedStringKey(text))
                .font(.system(size: 17, weight: .light, design: .rounded))
                .foregroundColor(textcolor)
            Spacer()
            ICON(sysname: "xmark", fcolor: color, size: 16, action: {
                self.show = false
            })
            .ifshow(style == .cancel)
        }
        .padding()
        .background(
            ZStack {
                Color.white
                color.opacity(0.1)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(lineWidth: 0.6).foregroundColor(color))
        .shadow(color: color.opacity(0.1), radius: 12, x: 0, y: 3)
        .shadow(color: Color.black.opacity(0.03), radius: 24, x: 0, y: 6)
        .padding()
        .gesture(gesture)
        .offset(y: offset)
        .simultaneousGesture(TapGesture().onEnded { _ in
            self.show = false
        })
    }
}

public struct ClearFullScreenBackView: UIViewRepresentable {
    public func makeUIView(context _: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // superview = BackgroundCleanerView
            // superview = UIHostingView
            let superView = view.superview?.superview
            superView?.backgroundColor = .clear
            superView?.layer.shadowColor = UIColor.clear.cgColor
            superView?.layer.shadowRadius = 0
            superView?.layer.shadowOpacity = 0
        }

//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            let superView = view.superview?.superview
//
//            UIView.animate(withDuration: 0.4) {
//                superView?.backgroundColor = UIColor(hexString: "000000", transparency: 0.3)
//            } completion: { _ in
//            }
//        }
        return view
    }

    public func updateUIView(_: UIView, context _: Context) {}
}

// 毛玻璃
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context _: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context _: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct BlurView: View {
    var colorSheme: UIBlurEffect.Style = .systemChromeMaterialLight
    var body: some View {
        VisualEffectView(effect: UIBlurEffect(style: colorSheme))
    }
}
