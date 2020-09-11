//
//  Team.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

class Team {
	// The game plays with 2 teans wich are instanciated at program lauch with default values
	
	var name: 		String			// Must be unique for the game
	var avatars 	= [Avatar]()	// Array of team avatars
	var lifePoints = 0				// Remaining life points counter for the team -> sum of avatars's life points remaining
	
	init(_ name: String) {
		self.name 	= name
	}
	
	func teamNameUpdate(_ name: String) {
		self.name	=	name
	}
	
	func teamLifeUpdate(_ points: Int) {
		self.lifePoints	+=	points
	}
	
	func teamGameInit(_ game: Game)
	{
		// Initialization of teams avatar's life points for a new game.
		self.lifePoints = 3 * game.gPoints[0]
		for indexA in 0...2 {																// Used to refer each team's avatar
			self.avatars[indexA].avatarPointsInit(game.allocations[indexA])	// -> can have differents values per avartar
		}
	}
	
	func teamAvatarsNWList() -> [String]
	{
		// This function return an array of formated string for the display : avatar's nickName + weapon
		let space				= String(repeating: " ", count: 12)	// lenght for formated strings
		var teamAvatarsNW		= [String]()
		for avatar in self.avatars {
				let part1 		= String(String(avatar.nickName + space).prefix(12)) + "      "
				let part2 		= String(String(avatar.weapon + space).prefix(12))
				teamAvatarsNW.append(part1+part2)
		}
		return teamAvatarsNW
	}
	
	func teamAvatarsNWDCList() -> [String]
	{
		// This function return an array of formated string for the display : avatar's nickName + weapon + damage + care
		let space				= String(repeating: " ", count: 12)
		var teamAvatarsNWDC	= [String]()
		for avatar in self.avatars {
			let item = String(String("\(avatar.nickName)-\(avatar.weapon)(-\(avatar.aPoints[1])/+\(avatar.aPoints[2]))" + space).prefix(30))
			teamAvatarsNWDC.append(item)
		}
		return teamAvatarsNWDC
	}
	
	func teamAvatarsLife() -> [Int]
	{
		// This function return an array of avatar's life points
		var avatarsLife		=	[Int]()
		for index in 0...2 {
			avatarsLife.append(self.avatars[index].aPoints[0])
		}
		return avatarsLife
	}
	
	func teamAvatarsLifeList() -> [String]
	{
		// This function return an array of formated string for the display : avatar's life points
		let space				= 	String(repeating: " ", count: 3)	// 3 is the lenght for theses formated strings
		var avatarsLifeList	=	[String]()
		for index in 0...2 {
			if self.avatars[index].aPoints[0] > 0 {
				avatarsLifeList.append(String(String(space + String(self.avatars[index].aPoints[0])).suffix(3)))
			} else {
				avatarsLifeList.append("†††")
			}
		}
		return avatarsLifeList
	}
	
	func teamAvatarDouble(_ name: String) -> Int
	{
		// This function checks that the new name of an avatar does not already exist in a team and returns the index if found
		for indexA in 0...self.avatars.count - 1 {
			if self.avatars[indexA].nickName == name {
				return indexA
			}
		}
		return -1
	}
}


