//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by byung-soo kwon on 2017. 7. 4..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func loadView() {
    
        
        // 지도 뷰 생성
        mapView = MKMapView()
        
        //지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        //MARK: 권한 설정 -> 꼭 CLLocationManager가 있어야 가능한 것인가?
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //MARK: 세그먼트 컨트롤
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        //MARK: 세그먼트 컨트롤 오토레이아웃
        let layoutMargins = view.layoutMarginsGuide
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,constant:8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        
        //MARK: 현재 위치 버튼
        let currentLoactionButton = UIButton()
        currentLoactionButton.setTitle("location", for: .normal)
        currentLoactionButton.setTitleColor(.black, for: .normal)
        currentLoactionButton.setTitleColor(.white, for: .highlighted)
     
        currentLoactionButton.addTarget(self, action: #selector(currentLocation), for: .touchUpInside)

        currentLoactionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLoactionButton)
        
        //MARK: 버튼 오토레이아웃
        NSLayoutConstraint(item: currentLoactionButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.8, constant: 0).isActive = true
        NSLayoutConstraint(item: currentLoactionButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.4, constant: 0).isActive = true
    
        
        //MARK: 줌 버튼
        let zoomButton = UIButton()
        zoomButton.setTitle("Zoom", for: .normal)
        zoomButton.setTitleColor(.black, for: .normal)
        zoomButton.setTitleColor(.white, for: .highlighted)
        
        zoomButton.addTarget(self, action: #selector(zoomUp), for: .touchUpInside)
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomButton)
    
        //MARK: 줌 버튼 오토레이아웃
        NSLayoutConstraint(item: zoomButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.8, constant: 0).isActive = true
        NSLayoutConstraint(item: zoomButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.5, constant: 0).isActive = true
        
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
   
    
    //MARK: Action
    func currentLocation(){
        
        print("현재 위치로 이동")
        let latitude = self.mapView.userLocation.coordinate.latitude
        let longitude = self.mapView.userLocation.coordinate.longitude
        
        //맵의 센터를 설정
        self.mapView.setCenter(.init(latitude: latitude, longitude: longitude), animated: true)
        
        //맵이 보이는 범위를 설정
        self.mapView.setRegion(.init(center: self.mapView.userLocation.coordinate, span: .init(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
        
      
    }
    
    
    //MARK: 현재 맵 위치를 줌 합니다.
    func zoomUp(){
        
        self.mapView.setRegion(.init(center: self.mapView.userLocation.coordinate, span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        print("현재 보이는 맵뷰가 바뀔것입니다.")
    
    }
    
    
    //MARK: 사용자의 위치가 업데이트 되면 알립니다.
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        
        print("위치가 바꼈다!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("MapViewController loaded its View.")
    
    }
}
