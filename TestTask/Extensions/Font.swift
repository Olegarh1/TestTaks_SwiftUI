//
// UIFont.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI

extension Font {
    enum FontType: String {
        case regular = ""
        case nunitoRegular = "NunitoSans-12ptExtraLight_Regular"
        case nunitoLight = "NunitoSans-12ptExtraLight_Light"
        case nunitoMedium = "NunitoSans-12ptExtraLight_Medium"
        case nunitoSemiBold = "NunitoSans-12ptExtraLight_SemiBold"
        case nunitoBold = "NunitoSans-12ptExtraLight_Bold"
        case nunitoExtraBold = "NunitoSans-12ptExtraLight_ExtraBold"
        case nunitoBlack = "NunitoSans-12ptExtraLight_Black"
    }

    static func setFont(_ type: FontType, size: CGFloat) -> Font {
        if type.rawValue.isEmpty {
            return .system(size: size)
        } else {
            return .custom(type.rawValue, size: size)
        }
    }
}
