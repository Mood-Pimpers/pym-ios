/* import Charts
 import Foundation
 import UIKit

 enum Weekday: Int, CaseIterable {
     case monday = 0
     case tuesday = 2
     case wednesday = 4
     case thursday = 6
     case friday = 8
     case saturday = 10
     case sunday = 12

     var shortLabel: String {
         switch self {
         case .monday: return "M"
         case .tuesday: return "T"
         case .wednesday: return "W"
         case .thursday: return "T"
         case .friday: return "F"
         case .saturday: return "S"
         case .sunday: return "S"
         }
     }
 }

 @objc(BarChartFormatter)
 public class WeekdayFormatter: NSObject, AxisValueFormatter {
     public func stringForValue(_ value: Double, axis _: AxisBase?) -> String {
         Weekday(rawValue: Int(value))?.shortLabel ?? ""
     }
 } */
