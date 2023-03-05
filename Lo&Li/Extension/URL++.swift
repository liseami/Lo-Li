//
//  URL++.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/2/17.
//

enum HomeNavigation: Hashable {
    case home, settings
}

extension URL {
    var isDeeplink: Bool {
        return scheme == "FantasyApp_Inside" // matches my-url-scheme://<rest-of-the-url>
    }

    var homeNavigationTarget: HomeNavigation? {
        guard isDeeplink else { return nil }
        switch host {
        case "home": return .home // matches my-url-scheme://home/
        case "settings": return .settings // matches my-url-scheme://settings/
        default: return nil
        }
    }
}
