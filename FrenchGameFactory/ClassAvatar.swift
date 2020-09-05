//
//  ClassAvatar.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

class Avatar {
	/*
	-  For each team, you can have up to 9 avatars
	-  Avatar playing are updated at each new game according to the scenario choosen
	*/
	
	var nickName:			String	// Must be unique for the game
	var weapon:				String	// Weapon used by the caracter to attack
	var aPoints	=			[Int]()	// Array of life(0), damage(1) and care(2) points
	
	init(_ nickName: String, _ weapon: String)	{
		self.nickName = nickName
		self.weapon   = weapon
		self.aPoints = game.gPoints
	}
	
	func avatarNameUpdate(_ nickName: String)
	{
		self.nickName	=	nickName
	}
	
	func avatarWeaponUpdate(_ weapon: String)
	{
		self.weapon	=	weapon
	}
	
	func avatarLifeUpdate(_ points: Int) {
		self.aPoints[0]	+=	points
	}
	
	//	Initialization of an avatar's points for a new game.
	func avatarPointsInit(_ points: [Int]) {
		self.aPoints	=	points

	}
}




