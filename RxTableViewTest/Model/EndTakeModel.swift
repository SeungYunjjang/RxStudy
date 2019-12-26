//
//  EndTakeModel.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

struct EndTakeModel {
    
    var regNo: Int
    var mainImage: UIImage
    var title: String
    var score: Int
    var spot: String
    var date: Int
    var startDate: String
    var endDate: String
    var attendCount: Int
    var successCount: Int
    
    init(_ list: Dictionary<String, Any>) {
        regNo = list["REG_NO"] as? Int ?? 0
        
        if let mainImageUrl = list["IMAGE"] as? String,
            let url = URL(string: "http://dev1.exs-mobile.com:23080/\(mainImageUrl)"),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            mainImage = image
        } else {
            mainImage = #imageLiteral(resourceName: "map_pin_icon_mini")
        }
        
        title = list["TITLE"] as? String ?? ""
        score = list["POINT"] as? Int ?? 0
        spot = list["SPOT"] as? String ?? ""
        date = list["DATE"] as? Int ?? 0
        attendCount = list["ATTEND_CNT"] as? Int ?? 0
        successCount = list["SUCCESS_CNT"] as? Int ?? 0
        
        let formetter = DateFormatter()
        formetter.dateFormat = "MM월 dd일"
        
        let _startDate = list["START_DATE"] as? Dictionary<String,Any> ?? [:]
        let startTime = _startDate["time"] as? Double ?? 0.0
        startDate = formetter.string(from: Date(timeIntervalSince1970: startTime / 1000))
        
        let _endDate = list["END_DATE"] as? Dictionary<String,Any> ?? [:]
        let endTime = _endDate["time"] as? Double ?? 0.0
        endDate = formetter.string(from: Date(timeIntervalSince1970: endTime / 1000))
    }
    
}

