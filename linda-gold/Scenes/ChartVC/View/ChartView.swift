//
//  ChartView.swift
//  linda-gold
//
//  Created by Chhun on 1/26/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import Charts

class ChartView: BaseView{
    let pieCharView = PieChartView()
    var productType: [ProductType] = []{
        didSet{
            let data = PieChartDataSet(entries: getPieChartDataSet(productTypes: productType))
            pieCharView.drawHoleEnabled = true
            pieCharView.legend.enabled = false
            data.drawValuesEnabled = false
            
            let getColor = BaseColor.diamondColor
            let jerwerlyColor = BaseColor.gemColor
            let diamond = BaseColor.jewerlyColor
            data.colors = [getColor, jerwerlyColor, diamond]
            pieCharView.data = PieChartData(dataSet: data)
        }
    }
    override func setupComponent() {
        addSubview(pieCharView)
        pieCharView.centerText = "center text"
        // hides entry label
        pieCharView.drawEntryLabelsEnabled = false
        // set clear color for entry label = hides entry label
        pieCharView.entryLabelColor = .clear
        // hides center text
        pieCharView.drawCenterTextEnabled = false
        // enable Scroll Chart
        pieCharView.isUserInteractionEnabled = false
        // size chart
        pieCharView.holeRadiusPercent = 0.60
//        var entries = [PieChartDataEntry]()
//        for x in 0..<4 {
//            entries.append(PieChartDataEntry(value: Double(x), label: ""))
//        }
//        let dataSet = PieChartDataSet(entries: entries)
//        dataSet.colors = ChartColorTemplates.colorful()
//        let datas = PieChartData(dataSet: dataSet)
//        pieCharView.data = datas
    }
    override func setupConstraint() {
        pieCharView.snp.makeConstraints { make in
            make.width.height.equalTo(scale(300)).priority(750)
            make.edges.equalToSuperview()
        }
    }
    
    func getPieChartDataSet(productTypes: [ProductType]) -> [PieChartDataEntry]{
        var pieChartDataEntries: [PieChartDataEntry] = []
        var totalAmount: Double = 0.0
        for productType in productTypes {
            totalAmount += productType.totalAmount
        }
        for productType in productTypes {
            let amount = (productType.totalAmount / totalAmount) * 100
            pieChartDataEntries.append(PieChartDataEntry(value: amount, label: productType.name))
        }
        return pieChartDataEntries
    }
}
