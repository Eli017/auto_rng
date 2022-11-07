import ActivityKit
import Foundation
struct PizzaDeliveryAttributes: ActivityAttributes {
   public typealias PizzaDeliveryStatus = ContentState
   public struct ContentState: Codable, Hashable {
      var driverName: String
      var deliveryTimer: ClosedRange<Date>
}
   var numberOfPizzas: Int
   var totalAmount: String
   var orderNumber: String
}
