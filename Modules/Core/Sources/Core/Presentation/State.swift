//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 23/11/21.
//

public enum State<T> {
    case initial
    case loading
    case error(String)
    case success(T)
}
