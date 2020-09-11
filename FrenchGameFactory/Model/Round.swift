//
//  Round.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

enum Actions {
	/* Contains the list of possible actions for an avatars.*/
	case attack, care
}

class Round {
	/*
	-  Each game consists of several rounds, which are stored in order to consult the progress during the game.
	-  Index of each team and avatar is memorized as well as the different information related to the round.
	*/
	
	let order:		Int			// Round order
	let token:		Int			//	Token for the round = team playing
	let indexA1:	Int			// Avatar index playing
	let indexA2:	Int			// avatar index opponent/fellow
	let action:		Actions		// Type of action during the round (attack, care)
	let points:		Int			// Number of damage or care points engaged during the round
	let xPoints:	Int			// Extra point (potitive or négative value) to add if extra choosen
	let xChoice:	Int			// Player choice if Extra offered during this round (-1= no offer, 0 = no, 1 = yes)
	let lifeT1:		Int			//	Remaining life points for team1
	let lifeT2:		Int			// Remaining life points for team1
	let lifeA1:		[Int]			// Array of remaining health points for team1 avatars at the end of the round
	let lifeA2:		[Int]			// Array of remaining health points for team2 avatars at the end of the round
	
	init(_ order: Int, _ token: Int, _ indexA1: Int, _ indexA2: Int, _ action: Actions, _ points: Int, _ xPoints: Int, _ xChoice: Int, _ lifeT1: Int, _ lifeT2: Int, _ lifeA1: [Int], _ lifeA2: [Int])
		//
	{
		// This function is called each time a round is finished to store the corresponding log
		self.order		= order
		self.token		= token
		self.indexA1	= indexA1
		self.indexA2	= indexA2
		self.action		= action
		self.points		= points
		self.xPoints	= xPoints
		self.xChoice	= xChoice
		self.lifeT1		= lifeT1
		self.lifeT2		= lifeT2
		self.lifeA1		= lifeA1
		self.lifeA2		= lifeA2
	}
	
	func roundLine(_ type: Int) -> String
	{
		// This function return a formated string in fixed lenght for the display
		var label	= ""
		if type  == 0 {
			let lifePoints: [Int]	= game.gameLifePoints()
			let order = "  0"
			let direction	= "     "
			let action		= " "
			let AvatarT1	= " "
			let AvatarT2	= " "
			let points		= "   "
			let xPoints		= "   "
			let xChoice		= "  "
			let lifeT1		= lifePoints[0]
			let lifeT2		= lifePoints[0]
			let lifeT1A1	= lifePoints[1]
			let lifeT1A2	= lifePoints[2]
			let lifeT1A3	= lifePoints[3]
			let lifeT2A1	= lifePoints[1]
			let lifeT2A2	= lifePoints[2]
			let lifeT2A3	= lifePoints[3]
			label =  "│ \(order) │ \(action) │ \(AvatarT1) │\(direction)│ \(AvatarT2) │ \(points)"
			label += " │ \(xPoints)\(xChoice) │ │ \(lifeT1)   \(lifeT1A1)   \(lifeT1A2)"
			label += "   \(lifeT1A3) │ │ \(lifeT2)   \(lifeT2A1)   \(lifeT2A2)   \(lifeT2A3) │"
			return label
		} else {
			let order		= String("   " + String(self.order)).suffix(3)
			let direction	= (self.token == 0 ? (self.action == .attack ? " ━▶  " : "◀━▶  ") : (self.action == .attack ? "  ◀━ " : "  ◀━▶"))
			let action		= (self.action == .attack ? "A" : "C")
			let AvatarT1	= "\(self.indexA1 + 1)"
			let AvatarT2	= "\(self.indexA2 + 1)"
			let points		= String("  " + String(self.points)).suffix(3)
			let xPoints		= (self.xPoints == 0 ? "   " : String("  " + String(self.xPoints)).suffix(3))
			let xChoice		= (self.xChoice == 1 ? ":Y" : (self.xChoice == 0 ? ":N" : "  "))
			let lifeT1		= (self.token == 0 && self.action == .attack) || (self.token == 1 && self.action == .care) ? "   " : String("  " + String(self.lifeT1)).suffix(3)
			let lifeT2		= (self.token == 1 && self.action == .attack) || (self.token == 0 && self.action == .care) ? "   " : String("  " + String(self.lifeT2)).suffix(3)
			let lifeT1A1	= (self.token == 0 && self.action == .attack) || (self.token == 1 && self.action == .care) ? "   " : String("  " + String(self.lifeA1[0])).suffix(3)
			let lifeT1A2	= (self.token == 0 && self.action == .attack) || (self.token == 1 && self.action == .care) ? "   " : String("  " + String(self.lifeA1[1])).suffix(3)
			let lifeT1A3	= (self.token == 0 && self.action == .attack) || (self.token == 1 && self.action == .care) ? "   " : String("  " + String(self.lifeA1[2])).suffix(3)
			let lifeT2A1	= (self.token == 1 && self.action == .attack) || (self.token == 0 && self.action == .care) ? "   " : String("  " + String(self.lifeA2[0])).suffix(3)
			let lifeT2A2	= (self.token == 1 && self.action == .attack) || (self.token == 0 && self.action == .care) ? "   " : String("  " + String(self.lifeA2[1])).suffix(3)
			let lifeT2A3	= (self.token == 1 && self.action == .attack) || (self.token == 0 && self.action == .care) ? "   " : String("  " + String(self.lifeA2[2])).suffix(3)
			label =  "│ \(order) │ \(action) │ \(AvatarT1) │\(direction)│ \(AvatarT2) │ \(points)"
			label += " │ \(xPoints)\(xChoice) │ │ \(lifeT1)   \(lifeT1A1)   \(lifeT1A2)"
			label += "   \(lifeT1A3) │ │ \(lifeT2)   \(lifeT2A1)   \(lifeT2A2)   \(lifeT2A3) │"
		}
		return label
	}
	
}




