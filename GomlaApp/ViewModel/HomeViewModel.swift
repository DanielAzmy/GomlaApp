//
//  HomeViewModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

final class HomeViewModel{
    var banners: [BannerModel] = [
        BannerModel(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
        BannerModel(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
        BannerModel(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
    ]
    
    var specialItems: [SpecialItemModel] = [
        SpecialItemModel(imageUrl: "https://images.unsplash.com/photo-1691480162735-9b91238080f6?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "French Croissant", size: "750 gm", price: 80.50, discount: 90.00, sellingUnit: "piece"),
        SpecialItemModel(imageUrl: "https://images.unsplash.com/photo-1691480162735-9b91238080f6?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "French Croissant", size: nil, price: 80.50, discount: 90.00, sellingUnit: "piece")
    ]
    
    var categories: [CategoryModel] = [
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
    ]
}
