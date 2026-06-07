//
//  Constants.swift
//  GomlaApp
//
//  Created by Daniel azmy on 01/06/2026.
//

import Alamofire
import Foundation

struct Constants{
    static let baseUrl = "https://api-test.halan.io/bff-mobile/ecommerce/v4.1/"
    static let token   = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJTZXNzaW9uSWQiOiIwMTllYTIyMi0xZTY1LTcwZTAtYmQ3Ni1hZDBlYmIyYTA5NWEiLCJQbGF0Zm9ybSI6IklPUyIsIlByb2ZpbGVUeXBlIjoiSEFMQU5fVVNFUl9QUk9GSUxFIiwiVmVyc2lvbiI6IjEuMCIsImlzcyI6ImhhbGFuLmlvIiwic3ViIjoiNjllNjI5NzllMmFmOWVjMmI5NWE3MDczIiwiYXVkIjpbImF1dGhvcml6YXRpb24iXSwiZXhwIjoxODEyMzcyNjA1LCJpYXQiOjE3ODA4MzY2MDV9._xQIQHn_A0B0o_niBgur29ut6ICBdv37ebSQrVmpdEb1_8CA_3BdANQtGw7i5XrUwDkKPSLBqGWEQA5woMm5Xw"
    static let baseicHeaders: HTTPHeaders = [
                                 "lat":"30.0595563",
                                "country": "eg",
                                "long": "31.2996639",
                                "device": "Mobile;Iphone;arm64;N/A;IOS;26.0.1;90DAFDC7-877B-40DF-B45E-04FE537F6774;en;10800;1775564110;13.3.1;00000000-0000-0000-0000-000000000000",
                                "language": "en",
                                "version": "ios-80131",
                                "Cookie": "TS016aa6fb=017e0ee1f2d6aa1f9765d657032c0fb7f982d312614b16dee747db795ca9ed42da1688bd71603205ffa392e65227bb1da786b68357",
                                "Authorization": token]
}
