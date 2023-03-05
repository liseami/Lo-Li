//
//  ModelListView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct OpenApiModel: Convertible {
    var id: String = "" // model-id-0",
    var object: String = "" // model",
    var owned_by: String = "" // organization-owner",
//    var permission: String = ""
}

class ModelListViewModel: FantasyListDataRequestProtocol {
    var pageindex: Int = 0

    @Published var datalist: [OpenApiModel] = []
    var listDataTarget: FantasyTargetType {
        OpenAPI.models
    }

    @Published var listDataReqStatus: ListDataRequestStatus = .isLoading
}

struct ModelListView: View {
    @StateObject var vm: ModelListViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if vm.listDataReqStatus == .isLoading {
                ProgressView()
            } else {
                LazyVStack {
                    ForEach(vm.datalist, id: \.id) { model in
                        HStack {
                            Text(model.id)
                                .ndFont(.body1b, color: .f1)
                            Spacer()
                        }
                        .frame(height: 44, alignment: .leading)
                        .addLoliCardBack()
                    }
                }
                .padding(.all, 6)
            }
        }
        .navigationTitle("模型选择")
        .padding(.all)
        .task {
            await vm.getListData()
        }
    }
}

struct ModelListView_Previews: PreviewProvider {
    static var previews: some View {
        ModelListView()
    }
}
