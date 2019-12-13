//
//  Place.swift
//  16_TravelBook
//
//  Created by Ashesh Singh on 12/2/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import Foundation

class Place {
    
    // Define attribute to model this class with Place Entity
    private var id = UUID()
    private var title : String
    private var subTitle : String
    private var latitude : Double
    private var longitude : Double
    
    init(title: String, subTitle: String, latitude: Double, longitude: Double) {
        self.title = title
        self.subTitle = subTitle
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func setId(id: UUID) {
        self.id = id
    }
    
    func getId() -> UUID {
        return id
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getSubTitle() -> String {
        return subTitle
    }
    
    func getLatitude() -> Double {
        return latitude
    }
    
    func getLongitude() -> Double {
        return longitude
    }
}
