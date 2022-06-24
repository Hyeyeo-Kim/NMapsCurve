//
//  ViewController.swift
//  NMapsCurve
//
//  Created by Yang on 06/24/2022.
//  Copyright (c) 2022 Yang. All rights reserved.
//

import UIKit
import NMapsMap
import NMapsCurve

class ViewController: UIViewController {
    
    private let samplePoints: [NMGLatLng] = [
        NMGLatLng(lat: 37.5196, lng: 126.9403),
        NMGLatLng(lat: 37.5112, lng: 127.098),
        NMGLatLng(lat: 37.4638, lng: 127.0367),
        NMGLatLng(lat: 37.3806, lng: 127.0029)]
    
    private let mapView = NMFMapView()
    
    override func viewDidLoad() {
        self.view.addSubview(mapView)
        
        mapView.frame = self.view.frame
        mapView.mapType = .navi
        mapView.isNightModeEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.drawCurveRoute()
        
        samplePoints.forEach {
            self.drawMarker(with: $0)
        }
    }
    
    private func drawCurveRoute() {
        let path = NMFCurvePath(point: samplePoints)!
        path.outlineWidth = 0
        path.width = 5
        
        path.mapView = self.mapView
    }
}

extension ViewController {
    func drawMarker(with latlng: NMGLatLng) {
        let marker = NMFMarker()
        marker.position = latlng
        marker.mapView = self.mapView
    }
}
