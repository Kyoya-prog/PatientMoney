import Charts
import Foundation
import UIKit

struct PatienceChartDataModel {
    var categoryTilte: String
    var money: Int
}

class PatienceChartsView: PieChartView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(data: [PatienceChartDataModel]) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        records = data
        constructDisplayData()
    }

    var  records: [PatienceChartDataModel] = [] {
        didSet {
            constructDisplayData()
        }
    }

    private func constructDisplayData() {
        var dataEntries: [ChartDataEntry] = []

        var foodMoney = 0
        var transportMoney = 0
        var drinkMoney = 0
        var communicationMoney = 0
        var wearMoney = 0
        var hobbyMoney = 0
        records.forEach {record in
            switch record.categoryTilte {
            case Category.categories[0].title:
                foodMoney += record.money

            case Category.categories[1].title:
                transportMoney += record.money

            case Category.categories[2].title:
                drinkMoney += record.money

            case Category.categories[3].title:
                communicationMoney += record.money

            case Category.categories[4].title:
                wearMoney += record.money

            case Category.categories[5].title:
                hobbyMoney += record.money

            default:
                break
            }
        }

        dataEntries.append(PieChartDataEntry(value: Double(foodMoney), label: Category.categories[0].title, data: Double(foodMoney)))
        dataEntries.append(PieChartDataEntry(value: Double(transportMoney), label: Category.categories[1].title, data: Double(transportMoney)))
        dataEntries.append(PieChartDataEntry(value: Double(drinkMoney), label: Category.categories[2].title, data: Double(drinkMoney)))
        dataEntries.append(PieChartDataEntry(value: Double(communicationMoney), label: Category.categories[3].title, data: Double(communicationMoney)))
        dataEntries.append(PieChartDataEntry(value: Double(wearMoney), label: Category.categories[4].title, data: Double(wearMoney)))
        dataEntries.append(PieChartDataEntry(value: Double(hobbyMoney), label: Category.categories[5].title, data: Double(hobbyMoney)))

        let dataSet = PieChartDataSet(entries: dataEntries, label: L10n.PatienceChartsView.Charts.description)

        data = PieChartData(dataSet: dataSet)

        var colors: [UIColor] = []

        for _ in 0..<dataEntries.count {
            let r = CGFloat.random(in: 0 ... 255) / 255.0
            let g = CGFloat.random(in: 0 ... 255) / 255.0
            let b = CGFloat.random(in: 0 ... 255) / 255.0
            let color = UIColor(red: r, green: g, blue: b, alpha: 1)

            colors.append(color)
        }

        dataSet.colors = colors
    }
}

#if canImport(SwiftUI)
import  SwiftUI

struct PatienceChartsViewWrapper: UIViewRepresentable {
    var records: [PatienceChartDataModel] = []

    typealias UIViewType = PatienceChartsView

    func makeUIView(context: Context) -> PatienceChartsView {
        PatienceChartsView()
    }

    func updateUIView(_ uiView: PatienceChartsView, context: Context) {
        uiView.records = records
    }
}

struct PatienceChartsVIewPreviews: PreviewProvider {
    static var previews: some View {
        PatienceChartsViewWrapper(records: [
            .init(categoryTilte: "飲食費", money: 100),
            .init(categoryTilte: "交通費", money: 200),
            .init(categoryTilte: "飲食費", money: 400),
            .init(categoryTilte: "服代", money: 500),
            .init(categoryTilte: "飲み代", money: 800),
            .init(categoryTilte: "趣味代", money: 280),
            .init(categoryTilte: "交際費", money: 500)
        ]).previewLayout(.fixed(width: 500, height: 500))
    }
}

#endif
