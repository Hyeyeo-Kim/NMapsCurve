//
//  LatLngRadians.swift
//  NMapsCurve
//
//  Created by SuperMove on 2022/06/24.
//

import Foundation

typealias LocationRadians = Double

struct LatLngRadians {
    var latitude: LocationRadians
    var longitude: LocationRadians
    
    static func +(left: LatLngRadians, right: LatLngRadians) -> LatLngRadians {
        return LatLngRadians(
            latitude: left.latitude + right.latitude,
            longitude: left.longitude + right.longitude
        )
    }
    
    static func -(left: LatLngRadians, right: LatLngRadians) -> LatLngRadians {
        return LatLngRadians(
            latitude: left.latitude - right.latitude,
            longitude: left.longitude - right.longitude
        )
    }
}
