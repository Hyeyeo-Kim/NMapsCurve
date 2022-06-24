//
//  NMapsCurvePath.swift
//  NMapsCurve
//
//  Created by SuperMove on 2022/06/24.
//

import NMapsMap

open class NMFCurvePath: NMFPath {
    
    public convenience init?(point: [NMGLatLng]) {
        var points: [NMGLatLng] = []
        
        point.enumerated().forEach {
            if $0.offset == point.count - 1 { return }
            
            points.append(contentsOf: NMFCurvePath.convertToCurve(departure: $0.element, arrival: point[$0.offset + 1]))
        }
        self.init(points: points)
    }
}

extension NMFCurvePath {
    static let EARTH_RADIUS: Double = 6371000
    
    static func convertToCurve(departure: NMGLatLng, arrival: NMGLatLng) -> [NMGLatLng] {
        let SE = departure.distance(to: arrival)
        
        let angle = Double.pi / 2
        let ME = SE / 2.0
        let R = ME / sin(angle / 2)
        let MO = R * cos(angle / 2)
        
        let heading = departure.heading(to: arrival)
        let mCoordinate = departure.computeOffset(distance: ME / NMFCurvePath.EARTH_RADIUS, heading: heading)
        
        let direction = departure.lng - arrival.lng > 0 ? -1.0 : 1.0
        let angleFromCenter = 90.0 * direction
        
        let oCoordinate = mCoordinate.computeOffset(distance: MO / NMFCurvePath.EARTH_RADIUS, heading: heading + angleFromCenter)
        
        var points: [NMGLatLng] = []
        
        points.append(NMGLatLng(lat: arrival.lat, lng: arrival.lng))
        
        let num = 100
        
        let initialHeading = oCoordinate.heading(to: arrival)
        let degree = (180.0 * angle) / Double.pi
        
        for i in 1...num {
            let step = Double(i) * (degree / Double(num))
            let heading: Double = (-1.0) * direction
            
            let pointOnCurvedLine = oCoordinate.computeOffset(distance: R / NMFCurvePath.EARTH_RADIUS, heading: initialHeading + heading * step)
            points.append(NMGLatLng(lat: pointOnCurvedLine.lat, lng: pointOnCurvedLine.lng))
        }
        
        points = points.reversed()
        
        return points
    }
}
