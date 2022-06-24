//
//  NMGLatLng+Extension.swift
//  NMapsCurve
//
//  Created by SuperMove on 2022/06/24.
//

import NMapsMap

public extension NMGLatLng {
    internal var latLngRadians: LatLngRadians {
        LatLngRadians(latitude: lat.radians, longitude: lng.radians)
    }
    
    func heading(to: NMGLatLng) -> Double {
        let bearing = Math.initialBearing(self.latLngRadians, to.latLngRadians)
        return Math.wrap(value: bearing * (180 / .pi), min: 0, max: 360)
    }
    
    func computeOffset(distance: Double,
                       heading: Double) -> NMGLatLng {
        let bearing = heading.radians
        let latLng1 = self.latLngRadians
        let sinLat2 = sin(latLng1.latitude) * cos(distance) + cos(latLng1.latitude) * sin(distance) * cos(bearing)
        let lat2 = asin(sinLat2)
        let y = sin(bearing) * sin(distance) * cos(latLng1.latitude)
        let x = cos(distance) - sin(latLng1.latitude) * sinLat2
        let lng2 = latLng1.longitude + atan2(y, x)
        return NMGLatLng(
            lat: lat2.degrees,
            lng: Math.wrap(value: lng2.degrees, min: -180, max: 180)
        )
    }
}

extension Double {
    var radians: Double {
        return self * (.pi / 180)
    }
    
    var degrees: Double {
        return self * (180 / .pi)
    }
}
