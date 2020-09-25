//
//  Avatar.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//
 
// Each team contains 3 avatars. Avatars's points are initialize at the begining of each game and updated during the game
class Avatar
{
	static var playing	= 0				// Avatar playing
	static var receiving	= 0				// Avatar receiving
	static var action		= 0				// action for the current avatar
	var nickName:			String			// Must be unique for the game
	var weapon:				Int				// Index of the weapon used by the caracter to attack
	var points	=			[Int]()			// Array of life(0), damage(1) and care(2) points
	
	init(_ nickName: String, _ indexW: Int) {
		self.nickName 		= nickName
		self.weapon   		= indexW
	}
	
	func avatarNameUpdate(_ nickName: String)
	{
		self.nickName		=	nickName
	}
	
	func avatarWeaponUpdate(_ indexW: Int)
	{
		self.weapon			=	indexW
	}
	
	func avatarLifeUpdate(_ points: Int) {		// Life points are updated during the game
		self.points[0]	+=	points
	}
	
	//	This method initialises avatar's points for a new game.
	func avatarPointsInit(_ points: [Int]) {
		self.points			=	points
	}

}




