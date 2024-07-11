//
//  CatAnalyticsManager.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Foundation
import FirebasePerformance

enum CatTrace: String {
	case catListLoad = "cat_list_load"
	case catDetailsLoad = "cat_details_load"
}


class CatAnalyticsManager {
	private static var traces: [String: Trace] = [:]
	
	static func startTrace(trace: CatTrace) {
		guard traces[trace.rawValue] == nil else {
			print("Trace with name \(trace.rawValue) already exists")
			return
		}
		let fbTrace = Performance.startTrace(name: trace.rawValue)
		traces[trace.rawValue] = fbTrace
	}
	
	static func stopTrace(trace: CatTrace) {
		guard let fbTrace = traces[trace.rawValue] else {
			print("Trace with name \(trace.rawValue) does not exist")
			return
		}
		fbTrace.stop()
		traces.removeValue(forKey: trace.rawValue)
	}
	
	static func setValue(_ value: String, forAttribute attribute: String, onTrace trace: CatTrace) {
		guard let trace = traces[trace.rawValue] else {
			print("Trace with name \(trace.rawValue) does not exist")
			return
		}
		trace.setValue(value, forAttribute: attribute)
	}
}
