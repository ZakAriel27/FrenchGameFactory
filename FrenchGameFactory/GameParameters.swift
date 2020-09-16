//
//  gameParameters.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

//┌────────────────────────────────────────────────────┐
//│               Display Game Parameters              │
//└────────────────────────────────────────────────────┘

func displayGameParameters()
{
	// As display is in monospaced font, all values must be formated in fixed lenght
	let space	= String(repeating: " ", count: 16)

	// Initializing data for display
	let t1Name	= String(String(teams[0].name + space).prefix(12))
	let t2Name	= String(String(teams[1].name + space).prefix(12))
	let team1	= teams[0].teamAvatarsNWList()	// List of team 1 information
	let team2	= teams[1].teamAvatarsNWList()	// List of team 2 information
	let armoury = weapons.weaponsList(8)			// List of armoury weapons for choosing
	let setting = game.gameSettingList()			// List of game settings
	
	// Display
	screenRefresh()
	print()
	print("                                                    􀂒────────────────────􀂒")
	print("􀂒─────────────────────────────────􀂒               /       􀂲LAY GAME    /")
	print("│ 􀂴uit    GAME PARAMETERS    􀂢elp │              􀂒────────────────────􀂒")
	print("􀂒─────────────────────────────────􀂒")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
	print("│ 􀃊     TEAM ONE: \(t1Name)     │ │ 􀃌    TEAM TWO: \(t2Name)     │")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
	print("│ 􀂒 Avatars           Weapons      │ │ 􀂒 Avatars           Weapons     │")
	print("│ 􀃎 \(team1[0]) │ │ 􀑵 \(team2[0])│")
	print("│ 􀘙 \(team1[1]) │ │ 􀃖 \(team2[1])│")
	print("│ 􀃒 \(team1[2]) │ │ 􀃘 \(team2[2])│")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
	print("│     ARMOURY       􀂮ext weapons → │ │ 􀂒     SETTING    􀂪ife 􀂚mg 􀂘are│")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
	print("│ 􀃊 \(armoury[0])   􀃌 \(armoury[1]) │ │ 􀑋Average points →  \(setting[0])  │")
	print("│ 􀃎 \(armoury[2])   􀘙 \(armoury[3]) │ │ 􀂜xtra \(setting[4])/\(setting[5])  │1  \(setting[1])  │")
	print("│ 􀃒 \(armoury[4])   􀑵 \(armoury[5]) │ │ 􀂬ode: \(setting[6]) │2  \(setting[2])  │")
	print("│ 􀃖 \(armoury[6])   􀃘 \(armoury[7]) │ │ 􀂺urn: \(setting[7]) │3  \(setting[3])  │")
	print("􀂒─────────────────────────────────􀂒 􀂒─────────────────────────────────􀂒")
}

//┌────────────────────────────────────────────────────┐
//│                   Game Parameters                  │
//└────────────────────────────────────────────────────┘

// Main loop
func gameParameters()
{
	weapons.weaponsInitList()	// Init index of the weapons list
	var status		= true		// Flag to exit the loop
	var visible		= false		// Flag to refresh the screen
	while status {
		if !visible {
			displayGameParameters()
			visible	= true
		}
		print("\n\nPress 􀃊..􀃘 to modify the teams or 􀂪 􀂚 􀂘 􀂜 􀂬 􀂺 to modify the setting : ", terminator:"")
		let choiceNum	= getKeyPress()
		if [1,2,3,4,5,6,7,8,99,100,101,104,108,109,112,113,116].contains(choiceNum) {
			switch choiceNum {
				case 1:					// Team1 name
					teamName(choiceNum)
				case 2:					// Team2 name
					teamName(choiceNum)
				case 3,4,5: 			// Team1 Avatars
					teamAvatar(1, choiceNum)
				case 6,7,8: 			// Team2 Avatars
					teamAvatar(2, choiceNum)
				case 99: 			// Care Points
					pointsAllocations(2)
				case 100: 			// Damage Points
					pointsAllocations(1)
				case 101: 			// Extra Chance
					gameExtra()
				case 104: 			// Help
					displayGameParameters()
					helps.helpDisplay(1)
				case 108: 			// Life Points
					pointsAllocations(0)
				case 109: 			// Care Mode
					game.careModeUpdate()
				case 112: 			// Play Game
					functionLink	= "Play"
					status			= false
				case 113:				// Quit
						functionLink	= ""
						status			= false
				case 116: 			// Turn Mode
					game.turnModeUpdate()
				default:
					break
			}
			if choiceNum	!= 104 {	// New values need a refresh except for help displayed
				visible	= false
			}
		}
	}
}

//┌────────────────────────────────────────────────────┐
//│              Game Parameters functions             │
//└────────────────────────────────────────────────────┘

// Choice -> Modify team's name
func teamName(_ choiceT: Int)
{
	let indexT			= choiceT - 1		// Team index
	var status			= true
	while status {
		print("\nEnter a name for Team \(choiceT) and press 􀅇: ", terminator:"")
		if let input 	= readLine() {
			let input 	= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count	== 0 {
				print("\nInput canceled! Press any key to continue: ", terminator:"")
				let _		= getKeyPress()
				status	= false
			} else {
				if teams[(indexT + 1) % 2].name == input {
					print("\nThis name is already used by the other team! Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
				} else {
					teams[indexT].teamNameUpdate(input)
					status	= false
				}
			}
		}
	}
}

// Choice -> Modify Avatar's name
func teamAvatar(_ choiceT: Int, _ choiceA: Int)
{
	let indexT			= choiceT - 1		// Team index
	let indexA			= choiceA - (choiceT == 1 ? 3 : 6)	// convert choice (3..6) depending on team choosen
	var status			= true
	while status {
		print("\nEnter a name for Avatar \(choiceA)  and press 􀅇: ", terminator:"")
		if let input	= readLine() {
			let input	= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count		 == 0 {
				print("\nInput canceled! Press any key to continue: ", terminator:"")
				let _		= getKeyPress()
				status	= false
			} else {
				var test			= true
				for index in 0...1 {
					let result	= teams[index].teamAvatarDouble(input)
					if (result	!= -1 && indexT == index) && (indexA != result) {
						print("\nThis name is already used in your team! Press any key to continue: ", terminator:"")
						let _		= getKeyPress()
						test		= false
					} else if (result != -1 && indexT != index) {
						print("\nThis name is already used by the other team! Press any key to continue: ", terminator:"")
						let _		= getKeyPress()
						test		= false
					}
				}
				if test == true {
					teams[indexT].avatars[indexA].avatarNameUpdate(input)
					weaponChoice(indexT, indexA)
					status	= false
				}
			}
		}
	}
}

// Choice -> Choose Avatar's weapon in Armory
func weaponChoice(_ indexT: Int, _ indexA: Int)
{
	print("(You can see more weapons in the Armory by pressing 􀂮ext)")
	var status			= true
	while status {
		print("\nPress 􀃊..􀃘 to choose a weapon in the Armory (or 􀂮ext to see more weapons): ", terminator:"")
		let choiceNum	= getKeyPress()
		print()				// Go to next line after a getKeyPress()
		if [0,1,2,3,4,5,6,7,8,110].contains(choiceNum) {
			switch choiceNum {
			case 0:			// Exit without changing weapon
				status			= false
			case 1...8:		// Weapon in Armory
				if choiceNum 	<= weapons.displayed {
					let index	= weapons.currentIndex + choiceNum - 1
					teams[indexT].avatars[indexA].avatarWeaponUpdate(weapons.weapon[index])
					status		= false
				}
			case 110:		// Next weapons from the armory
				weapons.currentIndex	= weapons.nextIndex
				displayGameParameters()
			default:
				break
			}
		}
	}
}


// Choice -> Modify points average for an avatar
func pointsAllocations(_ type: Int)
{
	let inputType			= (type == 0 ? "Life" : (type == 1 ? "Damage" : "Care"))
	var inputCount			=	0			// Number of loops for full data entry
	var gPoints				= 	0			//	Average for a single avatar
	var gAllocations		=	[0,0,0]	// Allocations values for the 3 avatars
	while inputCount		!= 3 {
		if inputCount		== 0 {
			print("\nEnter average \(inputType) points for an avatar and press 􀅇: ", terminator:"")
		} else if inputCount == 1 {
			print("\n\(inputType) points to share = \(gPoints * 3). Enter number of points for the FIRST AVATAR and press 􀅇: ", terminator:"")
		} else {
			print("\n\(inputType) points remaining to share = \(gPoints * 3 - gAllocations[0]). Enter number of points for the SECOND AVATAR and press 􀅇: ", terminator:"")
		}
		if let input	= readLine() {
			let input 	= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count	== 0 {
				print("\nInput canceled! Press any key to continue: ", terminator:"")
				let _ = getKeyPress()
				inputCount 	= 0		// To escape from the while loop
			} else if let inputNum	= Int(input) {
				switch inputCount {
				case 0:
					if (inputNum < 0 || inputNum > 999) {
						print("\nRange of \(inputType) points: > 0 & <= 999. Press any key to continue: ", terminator:"")
						let _	= getKeyPress()
					} else {
						gPoints				= inputNum
						inputCount			+= 1
					}
				case 1:
					if inputNum > (gPoints * 3 - 2) || inputNum < 1 {
						print("\nYou must enter a value between 1 and (\(gPoints * 3 - 2). Press any key to continue: ", terminator:"")
						let _	= getKeyPress()
					} else {
						gAllocations[0]	= inputNum
						inputCount			+= 1
					}
				case 2:
					if inputNum	>= (gPoints * 3 - gAllocations[0] - 1) || inputNum < 1 {
						print("\nYou must enter a value between 1 and \(gPoints * 3 - gAllocations[0] - 1). Press any key to continue: ", terminator:"")
						let _	= getKeyPress()
					} else {
						gAllocations[1]	= inputNum
						gAllocations[2]	= gPoints * 3 - gAllocations[0] - gAllocations[1]
						game.gamePointsUpdate(type, gPoints, gAllocations)
						inputCount			+= 1
					}
				default:
					break
				}
			}
		}
	}
}

// Choice -> Modify extraChance
func gameExtra()
{
	var inputCount		=	0
	var extra			=	[0,0]
	while inputCount	!= 2 {
		if inputCount	== 0 {
			print("\nEnter a percentage value (0..99) defining the probability to have an extra offer and press 􀅇: ", terminator:"")
		} else {
			print("\nEnter the number of points (0..99) that can be added or deducted by an extra offer and press 􀅇: ", terminator:"")
		}
		if let input 	= readLine() {
			let input	= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count == 0 {
				print("\nInput canceled! Press any key to continue: ", terminator:"")
				let _ 		= getKeyPress()
				inputCount	=	2
			} else if let inputNum	= Int(input) {
				if inputNum		> 0 && inputNum <= 99 {
					extra[inputCount]	=	inputNum
					inputCount			+= 1
					if inputCount		== 2 {
						game.gameExtraUpdate(extra)
					}
				} else {
					print("\nRange of value is: > 0 & =< 99. Press any key to continue: ", terminator:"")
					let _					= getKeyPress()
				}
			}
		}
	}
}
