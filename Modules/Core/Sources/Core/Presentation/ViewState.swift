//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 23/11/21.
//

public enum ViewState<T> {
    case initial
    case loading
    case error(String)
    case success(T)
}
