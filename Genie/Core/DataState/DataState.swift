//
//  DataState.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 18/02/23.
//

import Foundation

public enum DataState<Value, Error> {
    case loading
    case success(Value?)
    case error(Error?)
}
