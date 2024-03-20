//
//  Constants.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/28/24.
//

import UIKit

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
}

enum Images {
    static let placeholder = UIImage(resource: .avatarPlaceholder)
    static let emptyStateLogo = UIImage(resource: .emptyStateLogo)
    static let ghLogo = UIImage(resource: .ghLogo)
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX1213mini = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhone1234 = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone14Pro = idiom == .phone && ScreenSize.maxLength == 852.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896
    static let isiPhone1213ProMax14Plus = idiom == .phone && ScreenSize.maxLength == 926
    static let isiPhone14ProMax = idiom == .phone && ScreenSize.maxLength == 932
    static let isiPad = idiom == .pad && ScreenSize.maxLength == 1024.0

    static func isiPhoneXAspectRario() -> Bool {
        return isiPhoneX1213mini || isiPhoneXsMaxAndXr
    }
}
