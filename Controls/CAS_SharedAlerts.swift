//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Alerts.swift
//   Author: Kevin Messina
//  Created: 7/1/21
// Modified:
// 
// ©2021-2022 Creative App Solutions, LLC. - All Rights Reserved.
//--------------------------------------------------------------------------------------------------------------------------
// NOTES:
//--------------------------------------------------------------------------------------------------------------------------
//

import Foundation
import SwiftUI

// MARK: - *** ALERTS ***
struct sharedAlerts {
    func incomplete(missingFieldName:String,missingFieldLocation:String,title:String? = "Incomplete Information",cancelTitle:String? = "OK") -> Alert {
        return Alert(
            title: Text(title!),
            message: Text("\n\( missingFieldName ) is invalid and is required to continue.\n\nLocation: \( missingFieldLocation )"),
            dismissButton: .cancel(Text(cancelTitle!))
        )
    }
    
    func disclaimer(text:String,title:String? = "Notice & Disclaimer",cancelTitle:String? = "OK") -> Alert {
        return Alert(
            title: Text(title!),
            message: Text(text),
            dismissButton: .cancel(Text(cancelTitle!))
        )
    }
    
    func simple(title:String,text:String,cancelTitle:String? = "OK") -> Alert {
        return Alert(
            title: Text(title),
            message: Text(text),
            dismissButton: .cancel(Text(cancelTitle!))
        )
    }

    func underConstruction() -> Alert {
        return Alert(
            title: Text("Under Construction"),
            message: Text("\nFunction/Feature not available yet... (T/B/D)"),
            dismissButton: .cancel(Text("OK"))
        )
    }
}
