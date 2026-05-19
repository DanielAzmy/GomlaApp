//
//  Endpoints.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {
    var baseURL: String { "https://api-test.halan.io/" }
    var headers: HTTPHeaders? { ["lat":"30.0595563",
                                 "country": "eg", "long": "31.2996639",
                                 "device": "Mobile;Iphone;arm64;N/A;IOS;26.0.1;90DAFDC7-877B-40DF-B45E-04FE537F6774;en;10800;1775564110;13.3.1;00000000-0000-0000-0000-000000000000",
                                 "language": "en",
                                 "version": "ios-80131",
                                 "Cookie": "TS016aa6fb=017e0ee1f2d6aa1f9765d657032c0fb7f982d312614b16dee747db795ca9ed42da1688bd71603205ffa392e65227bb1da786b68357",
                                 "Authorization": "BBearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJTZXNzaW9uSWQiOiIwMTlkYjVlNi1hZmU0LTczMzMtODMxNy1hZGU5OTlhYWNhMWMiLCJQbGF0Zm9ybSI6IklPUyIsIlByb2ZpbGVUeXBlIjoiSEFMQU5fVVNFUl9QUk9GSUxFIiwiVmVyc2lvbiI6IjEuMCIsImlzcyI6ImhhbGFuLmlvIiwic3ViIjoiNjllNjI5NzllMmFmOWVjMmI5NWE3MDczIiwiYXVkIjpbImF1dGhvcml6YXRpb24iXSwiZXhwIjoxODA4NDA5Mjg3LCJpYXQiOjE3NzY4NzMyODd9.WsbTNXRtbzFgY3YMpMD0FP-vo2TDCWZNsChY2cBAta0AXfBWjhXWOOdG1ZNthdq1H9pugp0lO0n38GYoMfcX0Q"] }
    var encoding: ParameterEncoding { URLEncoding.default }
    var url: String { baseURL + path }
}
