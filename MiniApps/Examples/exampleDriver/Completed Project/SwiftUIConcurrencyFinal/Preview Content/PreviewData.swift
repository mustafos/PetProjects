//
//  PreviewData.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-17.
//

import Foundation

var coursePreviewData: Course = load("CourseData.json")
var courseListPreviewData = Array(repeating: coursePreviewData, count: 5)
