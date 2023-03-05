//
//  PFSheet.swift
//  Cashmix
//
//  Created by Liseami on 2021/11/19.
//

import SwiftUI

struct PF_SheetView<Content>: View where Content: View {
    let content: () -> Content

    @Binding var isPresented: Bool

    @GestureState private var offset: CGFloat = 0
    @State private var bodyHeight: CGFloat = 0
    @State private var endoffset: CGFloat = 0
    @State private var showBackBlack: Bool = false
    var backcornerRadius: CGFloat = 32
    var backColor: Color = .white
    var isSheetStyle: Bool = false

    init(isPresented: Binding<Bool>, backcornerRadius: CGFloat = 32, backColor: Color, isSheetStyle: Bool = false, content: @escaping () -> Content)
    {
        self.backcornerRadius = backcornerRadius
        self.backColor = backColor
        self.content = content
        self.isSheetStyle = isSheetStyle
        _isPresented = isPresented
    }

    @ViewBuilder
    var body: some View {
        // 手势
        let gesture = DragGesture(minimumDistance: 4, coordinateSpace: CoordinateSpace.global)
            .updating($offset, body: { value, out, _ in
                out = value.translation.height
            })
            .onEnded { value in
                if value.translation.height > (bodyHeight * 0.33) {
                    mada(.impact(.rigid))
                    showBackBlack = false
                    endoffset = value.translation.height
                    withAnimation(.NaduoSpring) {
                        isPresented = false
                    }
                }
            }

        ZStack {
            if !isSheetStyle {
//                (showBackBlack ? Color.black : Color.white)
//                    .opacity(0)
//                    .gesture(gesture)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        mada(.impact(.rigid))
//                        showBackBlack = false
//                        DispatchQueue.main.async {
//                            withAnimation(.spring()) {
//                                isPresented.toggle()
//                            }
//                        }
//                    }
//                    .ifshow(showBackBlack)
            } else {
                Button {
                    withAnimation {
                        mada(.impact(.rigid))
                        isPresented.toggle()
                    }
                } label: {
                    Color.white.opacity(0).ignoresSafeArea()
                }
            }

            VStack {
                Spacer()
                Group {
                    VStack(spacing: 0) {
                        content()
                            .background(backColor
                                .clipShape(RoundedCorner(radius: backcornerRadius, corners: [.topLeft, .topRight]))
                                .ignoresSafeArea())
                            .ignoresSafeArea()
                            .background(back)
                    }
                }
                .animation(.NaduoSpring, value: offset)
                .offset(y: offset > 0 ? offset : 0)
                .offset(y: offset == 0 ? endoffset : 0)
                .gesture(gesture)
                .ignoresSafeArea()
            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.34) {
//                    withAnimation(.PFSpring) {
//                        showBackBlack = true
//                    }
//                }
//            }
        }
    }

    @ViewBuilder
    var back: some View {
        GeometryReader(content: { proxy in
            Color.clear
                .onAppear {
                    self.bodyHeight = proxy.size.height
                }
        })
    }
}

public extension View {
    func PF_Sheet<Content>(isPresented: Binding<Bool>, capsulebarColor _: Color = .black, backcornerRadius: CGFloat = 32, backColor: Color, @ViewBuilder content: @escaping () -> Content) -> some View where Content: View {
        PF_FullScreen(isPresented: isPresented, backClear: true, onDismiss: {}, content: {
            PF_SheetView(isPresented: isPresented, backcornerRadius: backcornerRadius, backColor: backColor, content: content)
        })
    }

    func PF_Sheet_SystemSheetStyle<Content>(isPresented: Binding<Bool>, capsulebarColor _: Color = .black, backcornerRadius: CGFloat = 32, backColor: Color, @ViewBuilder content: @escaping () -> Content) -> some View where Content: View {
        PF_SystemSheet(isPresented: isPresented, onDismiss: {}, backClear: true) {
            PF_SheetView(isPresented: isPresented, backcornerRadius: backcornerRadius, backColor: backColor, isSheetStyle: true, content: content)
        }
    }
}

struct PF_SheetViewExample: View {
    @State private var PF_Sheet: Bool = false
    @State private var PF_Sheet_SystemSheetStyle: Bool = false
    var body: some View {
        ZStack {
            NavigationView {
                Color.yellow
                    .navigationTitle("The Big Blue")
                    .navigationBarTitleDisplayMode(.large)
            }
            VStack {
                Button {
                    //                withAnimation(){
                    PF_Sheet = true
                    //                }
                } label: {
                    Text("PF_Sheet")
                }

                Button {
                    //                withAnimation(){
                    PF_Sheet_SystemSheetStyle = true
                    //                }
                } label: {
                    Text("PF_Sheet_SystemSheetStyle")
                }
            }
        }
        .PF_Sheet_SystemSheetStyle(isPresented: $PF_Sheet_SystemSheetStyle, capsulebarColor: .red, backcornerRadius: 24, backColor: .red, content: {
            VStack {
                ForEach(0 ..< 4) { _ in
                    HStack {
                        Spacer()
                        ICON(sysname: "xmark", fcolor: .black, size: 12, fontWeight: .medium) {}
                        Spacer()
                    }
                    .padding()
                }
            }
        })
        .PF_Sheet(isPresented: $PF_Sheet, capsulebarColor: .red, backcornerRadius: 32, backColor: .red) {
            VStack {
                ForEach(0 ..< 4) { _ in
                    HStack {
                        Spacer()
                        ICON(sysname: "xmark", fcolor: .black, size: 12, fontWeight: .medium) {}
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

struct PF_SheetViewExample_Previews: PreviewProvider {
    static var previews: some View {
        PF_SheetViewExample()
        PF_SheetView(isPresented: .constant(true), backColor: Color.red) {
            Text("dhha")
        }
    }
}
