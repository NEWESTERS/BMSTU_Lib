//
//  Constants.swift
//  BMSTU Lib
//
//  Created by Nikita Balikhin on 15.03.2018.
//  Copyright © 2018 LandSlide. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let SEARCH_URL = "http://library.bmstu.ru/WCFServices/LibCatalog.svc/xml/search/?inStockOnly=1&topCount=50&q="

let BOOK_URL = "http://library.bmstu.ru/WCFServices/SearchAPI.svc/cat/GetById/?id="
