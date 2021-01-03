//
//  PixelWorldMapView.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/03.
//

import UIKit

final class PixelMapView: UIView {
  typealias Model = World.Model
  typealias Location = WorldMap.Model.Location
  
  private var locationSize: CGSize {
    CGSize(width: bounds.width / 78, height: bounds.height / 53)
  }
  
  func drawCountries(_ countries: [Model.Country]) {
    layoutIfNeeded()
    self.layer.sublayers?.removeAll()
    countries.forEach { drawCountry($0) }
  }
  
  private func drawCountry(_ country: Model.Country) {
    guard let level = country.status?.level,
          let locations = WorldMap.Model.all[country.code]?.locations
    else { return }
    
    drawLocations(locations, level: level)
  }
  
  private func drawLocations(_ locations: [Location], level: Int) {
    locations.forEach { drawLocation($0, level: level) }
  }
  
  private func drawLocation(_ location: Location, level: Int) {
    let color: UIColor
    switch level {
    case 0:
      color = .mapLevel0
    case 1:
      color = .mapLevel1
    case 2:
      color = .mapLevel2
    case 3:
      color = .mapLevel3
    case 4:
      color = .mapLevel4
    case 5:
      color = .mapLevel5
    default:
      color = .breathingWhite
    }
    let center: CGPoint = CGPoint(
      x: CGFloat(locationSize.width * CGFloat(location.x)),
      y: CGFloat(locationSize.height * CGFloat(location.y))
    )
    let path: UIBezierPath = UIBezierPath(
      arcCenter: center,
      radius: locationSize.width/2,
      startAngle: CGFloat(0),
      endAngle: CGFloat(Double.pi * 2),
      clockwise: true
    )
    let circle: CAShapeLayer = CAShapeLayer().then {
      $0.path = path.cgPath
      $0.fillColor = color.cgColor
    }
    self.layer.addSublayer(circle)
  }
}
