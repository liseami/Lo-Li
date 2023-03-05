//
//  BoundsPreference.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/7/22.
//

import Foundation

// View上报坐标信息..
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Value = nil
    static func reduce(
        value: inout Value,
        nextValue: () -> Value)
    {
        value = nextValue()
    }
}


struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct HeightKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// Post图片上报坐标信息，环境穿透...
struct MessageIdAndBoundsPreference: PreferenceKey {
    // MessageId : Message气泡坐标空间
    typealias Value = [String: Anchor<CGRect>]
    static var defaultValue: Value = [:]
    static func reduce(
        value: inout Value,
        nextValue: () -> Value)
    {
        // 键不变，值变
        value.merge(nextValue()) { $1 }
    }
}



// Post图片上报坐标信息，环境穿透...
struct SingleImageStrPreference: PreferenceKey {
    // Post图片信息ImageDetailInfo : Message气泡坐标空间
    typealias Value = [String: Anchor<CGRect>]
    static var defaultValue: Value = [:]
    static func reduce(
        value: inout Value,
        nextValue: () -> Value)
    {
        value.merge(nextValue()) { $1 }
    }
}
