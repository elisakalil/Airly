//
//  Extensions.swift
//  Airly
//
//  Created by Elisa Kalil on 28/01/25.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension String {
  func formattedTemperature(locale: Locale = .current) -> String {
    guard let doubleValue = Double(self) else { return self }
    return doubleValue.formattedTemperature(locale: locale)
  }
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
    
    func formattedTemperature(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        let value = self > 100 ? self / 10 : self
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
