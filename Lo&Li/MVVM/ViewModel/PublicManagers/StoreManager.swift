////
////  BuyViewModel.swift
////  LifeLoop
////
////  Created by 赵翔宇 on 2022/11/23.
////
//
//import Foundation
//import StoreKit
//
//class StoreManager: ObservableObject {
//    init() {
//        // 初始化
//        self.selectedProductId = UserManager.shared.selectedProductIdOnAppear
//        // Start a transaction listener as close to app launch as possible so you don't miss any transactions.
//        self.updateListenerTask = self.listenForTransactions()
//        Task {
//            // 获取商品
//            await getProduct()
//            // 订购状态
//            await updateUserProductStatus()
//        }
//    }
//
//    // 更新用户产品信息
//    @MainActor
//    func updateUserProductStatus() async {
//        var purchasedLifetimemembership: Product?
//        var purchasedSubscriptions: [Product] = []
//
//        for await result in Transaction.currentEntitlements {
//            do {
//                // 判断交易是否通过验证
//                let transaction = try checkVerified(result)
//                // 通过验证的交易，区分交易的类型
//                switch transaction.productType {
//                // 自动订阅:月度、年度会员
//                case .autoRenewable:
//                    if let subscription = products.first(where: { $0.id == transaction.productID }) {
//                        purchasedSubscriptions.append(subscription)
//                    }
//                // 非消耗品:终身会员
//                case .nonConsumable:
//                    if let lifetimemembership = products.first(where: { $0.id == transaction.productID }) {
//                        purchasedLifetimemembership = lifetimemembership
//                    }
//                // 非自动订阅
//                case .nonRenewable:
//                    break
//                // 消耗品
//                case .consumable:
//                    break
//                default:
//                    break
//                }
//            } catch {}
//        }
//        self.subscriptions = purchasedSubscriptions
//        lifetimemembership = purchasedLifetimemembership
//        var purchasedProductIds = self.subscriptions.map { Product in
//            Product.id
//        }
//        if let lifetimemembership {
//            purchasedProductIds.append(lifetimemembership.id)
//        }
//        withAnimation(.spring()) {
//            UserManager.shared.purchasedProductIds = purchasedProductIds
//        }
//    }
//
//    typealias Transaction = StoreKit.Transaction
//
//    public enum StoreError: Error {
//        case failedVerification
//    }
//
//    enum ProductType: String, CaseIterable {
//        case mounth = "mountainlopper_vip_mounth_1"
//        case year = "mountainlopper_vip_year_1"
//        case lifetimemembership = "mountainlopper_vip_lifetimemembership_1"
//
//        var title: String {
//            switch self {
//            case .year: return "年度会员"
//            case .mounth: return "月度会员"
//            case .lifetimemembership: return "纯想理心社会员"
//            }
//        }
//
//        var description: String {
//            switch self {
//            case .year: return "¥4.00/月"
//            case .mounth: return "¥9.00/月"
//            case .lifetimemembership: return "App终身永久会员"
//            }
//        }
//
//        var buyBtnTitle: String {
//            switch self {
//            case .year: return "升级至Pro - 年度会员"
//            case .mounth: return "升级至Pro - 月度会员"
//            case .lifetimemembership: return "升级至Pro - 终身会员"
//            }
//        }
//
//        var functionDescription: [StoreManager.Features] {
//            switch self {
//            case .mounth: return [.dataStatistics, .unlimitedEvents]
//            case .year: return [.dataStatistics, .unlimitedEvents, .customFocusWallpaper, .diaryFunction]
//            case .lifetimemembership: return StoreManager.Features.allCases
//            }
//        }
//    }
//
//    var productIDs: [String] {
//        ProductType.allCases.map { $0.rawValue }
//    }
//
//    // 监听购买
//    var updateListenerTask: Task<Void, Error>?
//    // 产品
//    @Published private(set) var products: [Product] = []
//    // 已经订阅的产品
//    @Published var subscriptions: [Product] = []
//    // 终身会员产品
//    @Published var lifetimemembership: Product?
//    // 当前选择的产品id
//    @Published var selectedProductId: String
//    @Published var isBuying: Bool = false
//
//    // 当前生效的产品
//    var currentProduct: Product? {
//        if let lifetimemembership {
//            return lifetimemembership
//        }
//        if !self.subscriptions.isEmpty {
//            return self.sortByPrice(self.subscriptions).last
//        }
//        return nil
//    }
//
//    // 是否可以购买
//    func canBuy(product: Product) -> Bool {
//        switch UserManager.shared.userMemberPlan {
//        case .none: return true
//        case .lifetime: return false
//        case .year: return product.id != ProductType.year.rawValue &&
//            product.id != ProductType.mounth.rawValue
//        case .mounth: return product.id != ProductType.mounth.rawValue
//        }
//    }
//
//    // 当前选择的产品
//    var selectedProduct: ProductType {
//        ProductType.allCases.first { ProductType in
//            ProductType.rawValue == self.selectedProductId
//        } ?? .year
//    }
//
//    @MainActor
//    func getProduct() async {
//        do {
//            // 获取商品
//            let products = try await Product.products(for: self.productIDs)
//            withAnimation(.spring()) {
//                self.products = self.sortByPrice(products)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    // 按价格排序商品
//    func sortByPrice(_ products: [Product]) -> [Product] {
//        products.sorted(by: { $0.price < $1.price })
//    }
//
//    /*
//     点击购买按钮
//     */
//    @MainActor
//    func tapBuyBtn() async {
//        if let selectedProduct = products.first(where: { Product in
//            Product.id == self.selectedProductId
//        }) {
//            do {
//                self.isBuying = true
//                _ = try await self.purchase(selectedProduct)
//                // 更新购买状态
//                await self.updateUserProductStatus()
//                self.isBuying = false
//            } catch {}
//        }
//    }
//
//    // 始终监听交易
//    func listenForTransactions() -> Task<Void, Error> {
//        return Task.detached {
//            for await result in Transaction.updates {
//                do {
//                    let transaction = try self.checkVerified(result)
//                    // 购买完成
////                    await self.updateCustomerProductStatus()
//                    // 结束交易
//                    await transaction.finish()
//                } catch {
//                    // StoreKit has a transaction that fails verification. Don't deliver content to the user.
//                    print("Transaction failed verification")
//                }
//            }
//        }
//    }
//
//    // 购买商品
//    func purchase(_ product: Product) async throws -> Transaction? {
//        // Begin a purchase.
//        let result = try await product.purchase()
//
//        switch result {
//        case .success(let verification):
//            let transaction = try checkVerified(verification)
////            // 告诉用户购买完成
////            await updatePurchasedIdentifiers(transaction)
//
//            // Always finish a transaction.
//            await transaction.finish()
//            return transaction
//        case .userCancelled, .pending:
//            return nil
//        default:
//            return nil
//        }
//    }
//
//    // 验证购买
//    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
//        // Check if the transaction passes StoreKit verification.
//        switch result {
//        case .unverified:
//            // 未经验证，抛出错误
//            throw StoreError.failedVerification
//        case .verified(let safe):
//            // 经过验证，抛出验证结果
//            return safe
//        }
//    }
//
////    func isPurchased(_ product: Product) async throws -> Bool {
////        //Determine whether the user purchases a given product.
////        switch product.type {
////        case .nonRenewable:
////            return purchasedNonRenewableSubscriptions.contains(product)
////        case .nonConsumable:
////            return purchasedCars.contains(product)
////        case .autoRenewable:
////            return purchasedSubscriptions.contains(product)
////        default:
////            return false
////        }
////    }
//}
//
//extension StoreManager {
//    struct FunctionDescription {
//        var icon: String
//        var title: String
//        var subline: String
//    }
//
//    enum Features: CaseIterable {
//        // 不限事件次数
//        case unlimitedEvents
//        // 数据统计
//        case dataStatistics
//        // 解锁全部App图标
//        case unlockAllApps
//        // 自定义专注壁纸
//        case customFocusWallpaper
//        // 写笔记
//        case takeNotes
//        // 日记功能
//        case diaryFunction
//        // 拍照留念功能
//        case photoMemories
//        // 加入纯想理心会社群
//        case joinPureThinkingCommunity
//        var description: FunctionDescription {
//            switch self {
//            // 不限事件次数
//            case .unlimitedEvents:
//                return .init(icon: "square-3-stack-3d", title: "不限事件个数（非会员3件）", subline: "这个功能可以让你创建无限次的事件，比如提醒、待办事项等，方便你记录日常事务，并有效管理时间。")
//            // 数据统计
//            case .dataStatistics:
//                return .init(icon: "chart-pie", title: "解锁数据统计", subline: "这个功能可以提供完整的数据统计功能，包括日常活动记录、统计分析和可视化图表等，方便你进行数据分析，并为你的决策提供有效支持。")
//            // 解锁全部App图标
//            case .unlockAllApps:
//                return .init(icon: "lock-open", title: "解锁全部App图标", subline: "这个功能可以解锁所有 App 图标，让你在主屏幕上看到的都是你想要的图标，而不会有不想要的图标占据屏幕空间。")
//            // 自定义专注壁纸
//            case .customFocusWallpaper:
//                return .init(icon: "puzzle-piece", title: "自定义专注壁纸", subline: "这个功能可以让你设置一张专注壁纸，在你进入专注模式时自动切换到这张壁纸。")
//            // 写笔记
//            case .takeNotes:
//                return .init(icon: "pencil-square", title: "写事件笔记", subline: "这个功能可以让你在 App 中记录笔记，比如文字、图片、音频等，方便你随时随地记录自己的想法和灵感。")
//            // 日记功能
//            case .diaryFunction:
//                return .init(icon: "bookmark-square", title: "日记功能", subline: "这个功能可以让你撰写日记，每天都可以记录自己的心情、活动和所思所想，让你保存记忆，并且能够回顾过去的点滴。")
//            // 拍照留念功能
//            case .photoMemories:
//                return .init(icon: "camera-outline", title: "专注拍照留念功能", subline: "在转山中拍照留念，甚至在未来以更多媒体格式记录自己的专注。")
//            // 加入纯想理心会社群
//            case .joinPureThinkingCommunity:
//                return .init(icon: "users", title: "加入纯想理心会社群", subline: "这个功能可以让你加入纯想理心会社群，与其他志同道合的人交流、分享经验和想法，提高自己的能力和知识水平。")
//            }
//        }
//    }
//}
