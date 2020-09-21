//
//  Weapon.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//


// Weapons is a structure containing all the weapons available
struct Weapons
{
	var weapon = ["BattleAxe","Bolas", "Club", "Sword", "GreatClub", "GreatSword", "Hammer", "Hatchet", "Khopesh",
					  "Mace", "MorningStar", "Nunchaku", "Spikedchain", "Staff", "StarKnife", "Trident"]
	var currentIndex	= 0	// Index in weapons struct for first weapon currently displayed
	var nextIndex		= 0	// Index for next weapon to be displayed according to the number of weapons displayed
	var displayed		= 0	// Count of weapons currently displayed in the list

	mutating func weaponsInitList()
	{
		self.currentIndex	= 0
		self.nextIndex		= 0
		self.displayed		= 0
	}
	
	// This method provide an array of formated string for the display : weapons names of the armoury
	func weaponsList(_ count: Int) -> [String]
	{
		let space			= String(repeating: " ", count: 12)	// lenght for formated strings
		var weaponsList	= [String]()
		if count				== 0 {										// Number of elements asked -> 0 means full list
			for weapon in self.weapon {
					weaponsList.append(String(String(weapon + space).prefix(12)))
				}
		} else {
			let indexW = weapons.currentIndex						// Start from the current index in weapons -> partial display
			for index in indexW...(min(self.weapon.count-1, indexW+count - 1)) {
				weaponsList.append(String(String(self.weapon[index] + space).prefix(12)))
			}
			weapons.displayed = weaponsList.count					// Number of weapons in the list -> can be less than
																				// number asked if end of weapons in armory
			weapons.nextIndex = ((weapons.currentIndex + weaponsList.count) % (self.weapon.count)) // Calculates the starting index for the next display -> can be 0 if the continuation corresponds to the beginning of the list)
			let modulo	= weaponsList.count % count
			if modulo	!= 0 {											// Completes the list with blank lines if less than lines asked
				for _ in 1...modulo {
					weaponsList.append(space)
				}
			}
		}
		return weaponsList
	}
}

