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
    var mapAnnotation: [MKAnnotation] = []
    var currentLocationCoordinate: CLLocationCoordinate2D?
    var count = 0
    
    override func loadView() {
        
        
        // 지도 뷰 생성
        mapView = MKMapView()
        
        //지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
        //현재 위치를 보여줍니다.
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isUserInteractionEnabled = true
        
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
        
        
        //MARK: 저장된 장소 둘러보기 버튼
        let favoriteLocation = UIButton()
        favoriteLocation.setTitle("Favorite", for: .normal)
        favoriteLocation.setTitleColor(.black, for: .normal)
        favoriteLocation.setTitleColor(.white, for: .highlighted)
        
        favoriteLocation.addTarget(self, action: #selector(favoriteLocations), for: .touchUpInside)
        favoriteLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteLocation)
        
        //MARK: 줌 버튼 오토레이아웃
        NSLayoutConstraint(item: favoriteLocation, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.8, constant: 0).isActive = true
        NSLayoutConstraint(item: favoriteLocation, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.3, constant: 0).isActive = true

        //맵 뷰에 터치 이벤트 추가
        let touchMapToPin = UITapGestureRecognizer(target: self, action: #selector(addAnnotation(gestureRecognizer:)))
        mapView.addGestureRecognizer(touchMapToPin)
        
        
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
    

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//     
//        if let annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "PinAnnotation"){
//            return annotationView
//        }else {
//        
//            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"PinAnnotation")
//            annotationView.animatesDrop = true
//            annotationView.canShowCallout = true
//            annotationView.isDraggable = true
//            annotationView.annotation = annotation
//            self.mapView.addAnnotation(annotation)
//            return annotationView
//        }
//    }

    
    //MARK: 현재 맵 위치를 줌 합니다.
    func zoomUp(){
        
        self.mapView.setRegion(.init(center: self.mapView.userLocation.coordinate, span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        print("현재 보이는 맵뷰가 바뀔것입니다.")
    
    }
    
    // 사용자가 지정한 핀을 순회한다.
    func favoriteLocations(){
        
        if !mapAnnotation.isEmpty{
            count = (count + 1) % mapAnnotation.count
            self.mapView.setCenter(mapAnnotation[count].coordinate, animated: true)
        }
    }
    
    
    //annotation 제스쳐 추가
    func addAnnotation(gestureRecognizer:UIGestureRecognizer){
        print("터치터치")
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let newCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
     
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        
        //mapAnnotation 배열에 추가.
        mapAnnotation.append(annotation)
        self.mapView.addAnnotation(annotation)
        print(mapAnnotation)
     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("MapViewController loaded its View.")
    
    }
}
