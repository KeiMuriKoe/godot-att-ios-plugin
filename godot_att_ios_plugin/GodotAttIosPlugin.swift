import Foundation
import AppTrackingTransparency
import AdSupport

@objcMembers public class GodotAttIosPluginSwift: NSObject {
    
    private func getStatusString(_ status: UInt) -> String {
        switch status {
        case 0: return "NotDetermined"
        case 1: return "Restricted"
        case 2: return "Denied"
        case 3: return "Authorized"
        default: return "Unknown"
        }
    }

    public func requestTracking(completion: @escaping (String) -> Void) {
        
        guard #available(iOS 14, *) else {
            print("Swift: iOS < 14. Returning Authorized.")
            completion("Authorized")
            return
        }
        
        let currentStatus = ATTrackingManager.trackingAuthorizationStatus
        print("Swift: Current status raw value: \(currentStatus.rawValue)")
        
        if currentStatus == .notDetermined {
            print("Swift: Status is NotDetermined. Requesting popup...")
            ATTrackingManager.requestTrackingAuthorization { status in
                let resStr = self.getStatusString(status.rawValue)
                print("Swift: Popup answered. Result: \(resStr)")
                completion(resStr)
            }
        } else {
            let resStr = self.getStatusString(currentStatus.rawValue)
            print("Swift: Already determined or restricted. Returning: \(resStr)")
            completion(resStr)
        }
    }
    
    public func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public func canShowRequestDialog() -> Bool {
        if #available(iOS 14, *) {
            return ATTrackingManager.trackingAuthorizationStatus == .notDetermined
        } else {
            return false
        }
    }

    public static func helloWorldFromSwift() {
        print("Swift: Hello World!")
    }
}
