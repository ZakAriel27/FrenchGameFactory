//
//  ClassWeapon.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

// Structure describing weapon
struct Weapon {
	var name: String
	
	init(_ name: String) {
		self.name = name
	}
}

// Structure containing weapons
struct Weapons {
	var weapon = [Weapon("BattleAxe"),
					  Weapon("Bolas"),
					  Weapon("Club"),
					  Weapon("Sword"),
					  Weapon("GreatClub"),
					  Weapon("GreatSword"),
					  Weapon("Hammer"),
					  Weapon("Hatchet"),
					  Weapon("Khopesh"),
					  Weapon("Mace"),
					  Weapon("MorningStar"),
					  Weapon("Nunchaku"),
					  Weapon("Spikedchain"),
					  Weapon("Staff"),
					  Weapon("StarKnife"),
					  Weapon("Trident")]

	func weaponsList(_ count: Int) -> [String]
	{
	// This function return an array of formated string for the display : weapons names of the armoury
		let space			= String(repeating: " ", count: 12)	// lenght for formated strings
		var weaponsList	= [String]()
		if count == 0 {										// Number of elements asked -> 0 means full list
			for weapon in self.weapon {
					weaponsList.append(String(String(weapon.name + space).prefix(12)))
				}
		} else {
			let indexW = weaponsIndex						// Start from the current index in weapons -> partial display
			for index in indexW...(min(self.weapon.count, indexW+count - 1)) {
				weaponsList.append(String(String(self.weapon[index].name + space).prefix(12)))
			}
			weaponsCountDisplayed = weaponsList.count	// Number of weapons in the list -> can be less than 8 if end of weapons
			weaponsNextIndex = ((weaponsIndex + weaponsList.count) % (self.weapon.count)) // Calculates the starting index for the next display -> can be 0 if the continuation corresponds to the beginning of the list)
			let modulo	= weaponsList.count % count
			if modulo	!= 0 {								// Completes the list with blank lines if less than 8 items
				for _ in 1...modulo {
					weaponsList.append(space)
				}
			}
		}
		return weaponsList
	}
}

