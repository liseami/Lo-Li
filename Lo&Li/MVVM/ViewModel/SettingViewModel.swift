class SettingViewModel: ObservableObject {
    var settingGroup: [SettingItem] =
        [.init(name: "OpenAPi", children: [
            .init(name: "Token"),
            .init(name: "模型选择"),
            .init(name: "颜色模式")
        ])
        ]
}


protocol BaseSettingItem {
    var name: String { get }
    var children: [SettingItem]? { get }
}

struct SettingItem: BaseSettingItem {
    var name: String
    var children: [SettingItem]? = []
}
