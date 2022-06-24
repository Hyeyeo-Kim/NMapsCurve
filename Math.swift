//
//  Math.swift
//  NMapsCurve
//
//  Created by SuperMove on 2022/06/24.
//

class Math {
    static func wrap(value: Double, min: Double, max: Double) -> Double {
      guard value < min || value >= max else {
        return value
      }

      return mod(value - min, modulus: max - min) + min
    }
    
    static func mod(_ value: Double, modulus: Double) -> Double {
      let truncated = value.truncatingRemainder(dividingBy: modulus)
      return (truncated + modulus).truncatingRemainder(dividingBy: modulus)
    }
    
    static func haversine(_ radians: LocationRadians) -> LocationRadians {
      let sinHalf = sin(radians / 2)
      return sinHalf * sinHalf
    }
    
    static func initialBearing(_ from: LatLngRadians, _ to: LatLngRadians) -> LocationRadians {
      let delta = to - from
      let cosLatTo = cos(to.latitude)
      let y = sin(delta.longitude) * cosLatTo
      let x = sin(delta.latitude) + sin(from.latitude) * cosLatTo * 2 * haversine(delta.longitude)
      return atan2(y, x)
    }

}
