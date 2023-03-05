//
//  Protocols.swift
//  FantasyWindow
//

//

import Foundation

/**
 列表数据请求协议
  */
public protocol FantasyListDataRequestProtocol: AnyObject, ObservableObject {
    associatedtype ListRowMod: Convertible
    var listDataTarget: FantasyTargetType { get }
    var listDataReqStatus: ListDataRequestStatus { get set }
    var pageindex: Int { get set }
    var datalist: [ListRowMod] { get set }
    func getListData(_ atKeyPath: String) async
    func loadMore(_ atKeyPath: String) async
}

extension FantasyListDataRequestProtocol {
    /// 刷新列表数据
    @MainActor
    func getListData(_ atKeyPath: String = .data) async {
        withAnimation(.NaduoSpring) {
            if self.listDataReqStatus != .isOK {
                self.listDataReqStatus = .isLoading
            }
        }
        self.pageindex = 1
        let (r, list) = await Networking.requestArray_async(listDataTarget, modeType: ListRowMod.self, atKeyPath: atKeyPath)
        if r.isSuccess {
            withAnimation(.NaduoSpring) {
                self.listDataReqStatus = .isOK
                if let list = list {
                    self.datalist.removeAll()
                    self.datalist = list
                    self.pageindex += 1
                }
            }
        } else {
            withAnimation(.NaduoSpring) {
                self.listDataReqStatus = .isNeedReTry
            }
        }
    }

    /// 加载更多
    @MainActor
    func loadMore(_ atKeyPath: String = .data) async {
        let (r, list) = await Networking.requestArray_async(listDataTarget, modeType: ListRowMod.self, atKeyPath: atKeyPath)
        if let newlist = list,!newlist.isEmpty, r.isSuccess {
            self.datalist.append(contentsOf: newlist)
            self.pageindex += 1
        }
    }
}

public enum ListDataRequestStatus {
    case isLoading
    case isNeedReTry
    case isOK
}

/**
 单一Mod请求协议
 */
public protocol FantasySingleDataRequestProtocol: AnyObject, ObservableObject {
    associatedtype SingleDataMod: Convertible
    var singleDataTarget: FantasyTargetType { get }
    var singleDataReqStatus: ListDataRequestStatus { get set }
    var singledata: SingleDataMod { get set }
    func getSingleData() async
}

extension FantasySingleDataRequestProtocol {
    /// 获取单一结果
    @MainActor
    func getSingleData() async {
        withAnimation(.NaduoSpring) {
            if self.singleDataReqStatus != .isOK {
                self.singleDataReqStatus = .isLoading
            }
        }
        let (r, mod) = await Networking.requestObject_async(singleDataTarget, modeType: SingleDataMod.self)
        if r.isSuccess {
            withAnimation(.NaduoSpring) {
                self.singleDataReqStatus = .isOK
                if let mod = mod {
                    self.singledata = mod
                }
            }
        } else {
            withAnimation(.NaduoSpring) {
                self.singleDataReqStatus = .isNeedReTry
            }
        }
    }
}
