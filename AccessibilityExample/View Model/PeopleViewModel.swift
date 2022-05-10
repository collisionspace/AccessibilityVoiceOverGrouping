//
//  PeopleViewModel.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import Foundation

struct PeopleViewModel {
    let people: People

    var attributedTitle: NSAttributedString {
        NSAttributedString(string: people.name + "\nAge: \(people.age)")
    }
}
