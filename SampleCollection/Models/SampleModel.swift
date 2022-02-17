//
//  SampleModel.swift
//  SampleCollection
//
//  Created by 松丸真 on 2022/02/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol Item {
    var id: String { get set }
}

struct TopItem: Item {
    var id: String
}

struct MiddleItem: Item {
    var id: String
}

struct FootItem: Item {
    var id: String
}

class SampleModel {
    func data() -> [SectionModel] {
        return [
            SectionModel(title: "top", items: [
                .tops(TopItem(id: "sample top"))
            ]),
            SectionModel(title: "middle", items: [
                .middles(MiddleItem(id: "sample middle"))
            ]),
            SectionModel(title: "foot", items: [
                .foots(FootItem(id: "sample foot")),
                .foots(FootItem(id: "sample foot")),
                .foots(FootItem(id: "sample foot")),
                .foots(FootItem(id: "sample foot")),
                .foots(FootItem(id: "sample foot")),
                .foots(FootItem(id: "sample foot"))
            ]),
        ]
    }
}

enum SectionItem {
    case tops(TopItem)
    case middles(MiddleItem)
    case foots(FootItem)
}
struct SectionModel: SectionModelType {
    typealias Item = SectionItem
    var items: [SectionItem]
    var title: String

    init(original: SectionModel, items: [Item]) {
        self = original
        self.items = items
    }
    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
}
