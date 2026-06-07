//
//  HomeViewModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

final class HomeViewModel{
    var banners: [BannerModel] = [
        BannerModel(id: "0", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
        BannerModel(id: "1", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
        BannerModel(id: "2", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe_OlHEe2L-0VtexCxjIV5tc0dLor3wd57Yg&s"),
    ]
    
    var specialItems: [Product] = [
        Product(id: "0", imageUrl: "https://images.unsplash.com/photo-1691480162735-9b91238080f6?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "French Croissant", size: "750 gm", price: 80.50, discount: 90.00, sellingUnit: "piece"),
        Product(id: "1", imageUrl: "https://images.unsplash.com/photo-1691480162735-9b91238080f6?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "French Croissant", size: nil, price: 80.50, discount: 90.00, sellingUnit: "piece")
    ]
    
    var categories: [CategoryModel] = [
        CategoryModel(id: "0", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "1", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "2", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "3", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "4", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "5", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "6", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
        CategoryModel(id: "7", imageUrl: "https://cdn-icons-png.flaticon.com/256/1261/1261163.png", name: "Vegetables"),
    ]
}
