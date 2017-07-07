//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by byung-soo kwon on 2017. 7. 4..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
 
    override func loadView() {
    
        
        // 지도 뷰 생성
        mapView = MKMapView()
        
        //지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
        
        
        //MARK: 세그먼트 컨트롤
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        let topLayoutMargins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,constant:8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: topLayoutMargins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: topLayoutMargins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        
        //MARK: 현재 위치 버튼
        let currentLoactionButton = UIButton()
        currentLoactionButton.setTitle("location", for: .normal)
        currentLoactionButton.setTitleColor(.black, for: .normal)
        currentLoactionButton.setTitleColor(.white, for: .highlighted)
     
        currentLoactionButton.addTarget(self, action: #selector(mapViewWillStartLocatingUser(_:)), for: .touchUpInside)

        currentLoactionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLoactionButton)
        
        let buttonXConstraint = currentLoactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let buttonYConstraint = currentLoactionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        buttonXConstraint.isActive = true
        buttonYConstraint.isActive = true

    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
   
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView){
        print("현재 위치로 이도")
        self.mapView.showsUserLocation = true
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("MapViewController loaded its View.")
    
    }
}
