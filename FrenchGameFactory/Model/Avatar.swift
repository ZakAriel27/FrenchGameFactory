//
//  Avatar.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

class Avatar {
	/*
	-  Avatar playing are updated at each new game according to the scenario choosen
	*/
	
	var nickName:			String	// Must be unique for the game
	var weapon:				String	// Weapon used by the caracter to attack
	var aPoints	=			[Int]()	// Array of life(0), damage(1) and care(2) points
	
	init(_ nickName: String, _ weapon: String, _ points: [Int])	{
		self.nickName 		= nickName
		self.weapon   		= weapon
		self.aPoints 		= points		//points corresponds to the default points values défined in the game settings
	}
	
	func avatarNameUpdate(_ nickName: String)
	{
		self.nickName		=	nickName
	}
	
	func avatarWeaponUpdate(_ weapon: String)
	{
		self.weapon			=	weapon
	}
	
	func avatarLifeUpdate(_ points: Int) {		// Life points are updated during the game
		self.aPoints[0]	+=	points
	}
	
	func avatarPointsInit(_ points: [Int]) {	//	Initialization of an avatar's points for a new game.
		self.aPoints		=	points

	}
}




