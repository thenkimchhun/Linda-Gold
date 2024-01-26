//
//  ChartVC.swift
//  linda-gold
//
//  Created by Chhun on 1/26/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import Charts


class ChartVC: BaseVC {
    let pieChart = PieChartView()
    let viewModel = HomeViewModel()
    override func setupComponent() {
        view.addSubview(pieChart)
        pieChart.centerText = "center text"
        // hides entry label
        pieChart.drawEntryLabelsEnabled = true
        
        // set clear color for entry label = hides entry label
        pieChart.entryLabelColor = .clear
        
        // hides center text
        pieChart.drawCenterTextEnabled = false
        // hides value label
        // enable Scroll Chart
        pieChart.isUserInteractionEnabled = false
        // size chart
        pieChart.holeRadiusPercent = 0.60
        //
       

    }
    override func setupEvent() {
        viewModel.delegate = self
        viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: AppStatus.FilterDay.year))
    }
    override func setupConstraint() {
        pieChart.snp.makeConstraints { make in
            make.width.height.equalTo(265)
            make.center.equalToSuperview()
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
    
    func calculatorAmount(gem: Double, jewerly: Double, diamont: Double)-> [Double]{
        let getAllTotal = (gem+jewerly+diamont)
        let gem = (gem / getAllTotal) * 100
        let jewerly = (jewerly / getAllTotal) * 100
        let diamont = (diamont / getAllTotal) * 100
        return [gem,jewerly,diamont]
    }
    
    
    func calculator(price: Double)-> Double{
        let total = (price / price + price +  price) * 100
        return Double(total)
    }
    
    
}

extension ChartVC: HomeDelegate{
    func onGetDahsbaordSaleOrderUpdateState() {
        switch viewModel.onGetDashboardSaleOrderUpdatestate {
        case .success:
            let data = PieChartDataSet(entries: getPieChartDataSet(productTypes: viewModel.saleOrderData?.productType ?? []))
            pieChart.drawHoleEnabled = true
            pieChart.legend.enabled = false
            data.drawValuesEnabled = false
            
            let getColor = UIColor.systemBlue
            let jerwerlyColor = UIColor.orange
            let diamond = UIColor.yellow
            data.colors = [getColor, jerwerlyColor, diamond]
            pieChart.data = PieChartData(dataSet: data)
            print("dataList: ==>", viewModel.saleOrderData?.productType ?? [])
            break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    
    func onGetAccountUpdateState() {
        
    }
    
    func onGetDashboardBuyBackUpdateState() {
        
    }
    
    
}




// 3  = 100%
//1. gem = 2000$ = 21,0526%
//2. je = 5000$ = 52.6315%
//3. d = 2500$ = 26.3157%
// 2000 + 5000 + 2500 = 9500
 // totalAmount / (get + je + d) * 100 =
//        let totalAmount = calculators(v1: 2000, v2: 5000, v3: 5000)
//        print("totalAmount: ==>",totalAmount)
