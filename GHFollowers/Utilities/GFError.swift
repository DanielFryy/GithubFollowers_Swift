//
//  GFError.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/27/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server is invalid. Please try again."
    case unableToFavourite = "There was an error favouriting thie user. Please try again."
    case alreadyInFavourites = "You've already favourited this user. You must REALLY like them!"
}
