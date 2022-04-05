//
//  Extensions.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
