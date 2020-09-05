//
//  ClassRound.swift
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
	-  Each game consists of several rounds, which are stored in order to consult the progress of the game.
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
	{
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
	
	func roundLine() -> String
	{
		// This function return a formated string for the display
		let order		= String("   " + String(self.order)).suffix(3)
		let action1		= (self.token == 0 ? " ◀━ " : "    ")
		let action2		= (self.token == 1 ? " ━▶ " : "    ")
		let action		= (self.action == .attack ? "A" : "C")
		let AvatarT1	= "\(self.indexA1 + 1)"
		let AvatarT2	= "\(self.indexA2 + 1)"
		let points		= String("   " + String(self.points)).suffix(3)
		let xPoints		= (self.xPoints == 0 ? "   " : String("   " + String(self.xPoints)).suffix(3))
		let xChoice		= (self.xChoice == 1 ? "/Y" : (self.xChoice == 0 ? "/N" : "  "))
		let lifeT1		= String("   " + String(self.lifeT1)).suffix(3)
		let lifeT2		= String("   " + String(self.lifeT2)).suffix(3)
		let lifeT1A1	= String("   " + String(self.lifeA1[0])).suffix(3)
		let lifeT1A2	= String("   " + String(self.lifeA1[1])).suffix(3)
		let lifeT1A3	= String("   " + String(self.lifeA1[2])).suffix(3)
		let lifeT2A1	= String("   " + String(self.lifeA2[0])).suffix(3)
		let lifeT2A2	= String("   " + String(self.lifeA2[1])).suffix(3)
		let lifeT2A3	= String("   " + String(self.lifeA2[2])).suffix(3)
		
		var label	= ""
		label =  "│ \(lifeT1) │ \(lifeT1A1) │ \(lifeT1A2) │ \(lifeT1A3) │\(action1)│ \(order)"
		label += " │ \(action) │ \(AvatarT1) │ \(AvatarT2) │ \(points) │ \(xPoints)\(xChoice)"
		label += " │\(action2)│ \(lifeT2) │ \(lifeT2A1) │ \(lifeT2A2) │ \(lifeT2A3) │"
		//	"│ T.1 │ A.1 │ A.2 │ A.3 │ ◀━ │ Rnd │A/C│Avatars│ Pts │ Extra │ ━▶ │ T.2 │ A.1 │ A.2 │ A.3 │")
		return label
	}
	
}

func roundLine0() -> String
{
	let lifePoints: [Int]	= game.gameLifePoints()
	var lifeStrings			= [String]()
	for value in lifePoints {
		lifeStrings.append(String(String("   " + String(value)).suffix(3)))
	}
	var label	=  "│ \(lifeStrings[0]) │ \(lifeStrings[1]) │ \(lifeStrings[2]) │ \(lifeStrings[3])"
	label 		+= " │    │   0 │   │   │   │     │       │    │ "
	label 		+= "\(lifeStrings[0]) │ \(lifeStrings[1]) │ \(lifeStrings[2]) │ \(lifeStrings[3]) │"
	return label
}



