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
	// As displayed in monospaced font, all values must be formated in fixed lenght
	let space	= String(repeating: " ", count: 16)

	// Initializing data for display
	let t1Name	= String(String(teams[0].name + space).prefix(12))
	let t2Name	= String(String(teams[1].name + space).prefix(12))
	let team1	= teams[0].teamAvatarsNWList()	// List of team 1 information
	let team2	= teams[1].teamAvatarsNWList()	// List of team 2 information
	let armoury = weapons.weaponsList(9)			// List of armoury weapons for choosing
	let setting = game.gameSettingList()			// List of game settings
	
	// Display
	screenRefresh()
//		print()
//		print("                                                          􀂒───────────────􀂒")
//		print("􀂒─────────────────────────────────􀂒                     /   􀂲LAY GAME   /")
//		print("│ 􀂴uit    GAME PARAMETERS    􀂢elp │                    􀂒───────────────􀂒")
//		print("􀂒─────────────────────────────────􀂒")
//		print("􀂒─────────────────────────────────􀂒 􀂒──────────────────────────────────􀂒")
//		print("│ 􀃊   TEAM:   \(t1Name)         │ │ 􀃌   TEAM:   \(t2Name)         │")
//		print("􀂒── Avatars ───────── Weapons ────􀂒 􀂒── Avatars ───────── Weapons ─────􀂒")
//	//	print("│ 􀂒 Avatars           Weapons      │ │ 􀂒 Avatars           Weapons     │")
//		print("│ 􀃎 \(team1[0]) │ │ 􀑵 \(team2[0]) │")
//		print("│ 􀘙 \(team1[1]) │ │ 􀃖 \(team2[1]) │")
//		print("│ 􀃒 \(team1[2]) │ │ 􀃘 \(team2[2]) │")
//		print("􀂒─────────────────────────────────􀂒 􀂒──────────────────────────────────􀂒")
//		print("􀂒─────────────────────────────────􀂒 􀂒──────────────────────────────────􀂒")
//		print("│     ARMOURY       􀂮ext weapons → │ │  ↙ Rules􀂒Points → 􀂪ife 􀂚mg 􀂘are│")
//		print("􀂒─────────────────────────────────􀂒 􀂒──────────────────────────────────􀂒")
//	//	print("│ 􀃈 \(armoury[0])   􀃊 \(armoury[1]) │ │ 􀑋 For Each Team →  \(setting[0])  │")
//	//	print("│ 􀃌 \(armoury[2])   􀃎 \(armoury[3]) │ │ 􀑋 The 3 Avatars ⤵                │")
//		print("│ 􀘙 \(armoury[4])   􀃒 \(armoury[5]) │ │ 􀂜xtra: \(setting[4])/\(setting[5])  ║ 1 \(setting[1])  │")
//		print("│ 􀑵 \(armoury[6])   􀃖 \(armoury[7]) │ │ 􀂬ode : \(setting[6]) ║ 2 \(setting[2])  │")
//		print("│ 􀃘 \(armoury[8])   􀑷 \(armoury[9]) │ │ 􀂺urn : \(setting[7]) ║ 3 \(setting[3])  │")
//		print("􀂒─────────────────────────────────􀂒 􀂒──────────────────────────────────􀂒")
	
	print(" 􀂒──────────────────────────────────────────────────────────────────────􀂒     􀂒────────────􀂒")
	print(" │ 􀂴uit                      GAME SETTINGS                         􀂢elp │    /  􀂲LAY GAME /")
	print(" 􀂒──────────────────────────────────────────────────────────────────────􀂒  􀂒─────────────􀂒")
	print(" 􀂒────────────────􀂒  􀂒──────────────────────────────────􀂒  􀂒───────────────────────────􀂒")
	print(" │  ARMOURY   􀂮ext │  │ 􀃊  TEAM:   \(t1Name)          │   │ 􀂒 Points  􀂪ife 􀂚mg 􀂘are │")
	print(" 􀂒────────────────􀂒  􀂒── Avatars ───────── Weapons ─────􀂒  􀂒───────────────────────────􀂒")
	print(" │ 􀃊 \(armoury[0])  │  │ 􀃌 \(team1[0]) │   │ 􀂒 Profil1: \(setting[0])  │")
	print(" │ 􀃌 \(armoury[1])  │  │ 􀃎 \(team1[1]) │   │ 􀂒 Profil2: \(setting[1])  │")
	print(" │ 􀃎 \(armoury[2])  │  │ 􀘙 \(team1[2]) │   │ 􀂒 Profil3: \(setting[2])  │")
	print(" │ 􀘙 \(armoury[3])  │  􀂒──────────────────────────────────􀂒  􀂒───────────────────────────􀂒")
	print(" │ 􀃒 \(armoury[4])  │  │ 􀃒  TEAM:   \(t2Name)          │   │ 􀂒 Rules                   │")
	print(" │ 􀑵 \(armoury[5])  │  􀂒── Avatars ───────── Weapons ─────􀂒  􀂒───────────────────────────􀂒")
	print(" │ 􀃖 \(armoury[6])  │  │ 􀑵 \(team2[0]) │   │ 􀂜xtra    : \(setting[3]) (\(setting[4])-\(setting[5])pts) │")
	print(" │ 􀃘 \(armoury[7])  │  │ 􀃖 \(team2[1]) │   │ Care 􀂬ode: \(setting[6])  │")
	print(" │ 􀑷 \(armoury[8])  │  │ 􀃘 \(team2[2]) │   │ 􀂺urn mode: \(setting[7])  │")
	print(" 􀂒────────────────􀂒  􀂒──────────────────────────────────􀂒  􀂒───────────────────────────􀂒")
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
		print("\n Press 􀃊..􀃘 to modify the teams or 􀂪 􀂚 􀂘 􀂜 􀂬 􀂺 to modify the setting : ", terminator:"")
		let choiceNum	= getKeyPress()
		if [1,2,3,4,5,6,7,8,99,100,101,104,108,109,112,113,116].contains(choiceNum) {
			switch choiceNum {
				case 1:					// Team1 name
					teamName(choiceNum)
				case 5:					// Team2 name
					teamName(choiceNum)
				case 2,3,4: 			// Team1 Avatars
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
					Game.helpMode	= !Game.helpMode
					if Game.helpMode {
						helps.helpDisplay(1)
					}
				case 108: 			// Life Points
					pointsAllocations(0)
				case 109: 			// Care Mode
					gameCareCount()
				case 112: 			// Play Game
					functionLink	= .play
					status			= false
				case 113:				// Quit
					functionLink	= .none
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
	let indexT				= choiceT - 1		// Team index
	var status				= true
	while status {
		print("\n Enter a name for Team \(choiceT) and press 􀅇: ", terminator:"")
		if let input 		= readLine() {
			let input 		= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count	== 0 {
				print("\n Input canceled! Press any key to continue: ", terminator:"")
				let _			= getKeyPress()
				status		= false
			} else {
				if teams[(indexT + 1) % 2].name == input {
					print("\n This name is already used by the other team! Press any key to continue: ", terminator:"")
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
	let indexT			= choiceT - 1								// Team index
	let indexA			= choiceA - (choiceT == 1 ? 2 : 6)	// convert choice (2..6) depending on team choosen
	var status			= true
	while status {
		print("\n Enter a name for Avatar \(choiceA)  and press 􀅇: ", terminator:"")
		if let input2	= readLine() {
			let input	= input2.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count		 == 0 {
				print("\n Input canceled! Press any key to continue: ", terminator:"")
				let _		= getKeyPress()
				status	= false
			} else {
				var test			= true
				for index in 0...1 {
					let result	= teams[index].teamAvatarDouble(input)
					if (result	!= -1 && indexT == index) && (indexA != result) {
						print("\n This name is already used in your team! Press any key to continue: ", terminator:"")
						let _		= getKeyPress()
						test		= false
					} else if (result != -1 && indexT != index) {
						print("\n This name is already used by the other team! Press any key to continue: ", terminator:"")
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
	var status			= true
	while status {
		print("\n Press 􀃈..􀑷 to choose a weapon in the Armory (or 􀂮ext to see more weapons): ", terminator:"")
		let choiceNum	= getKeyPress()
		print()				// Go to next line after a getKeyPress()
		if [0,1,2,3,4,5,6,7,8,9,110].contains(choiceNum) {
			switch choiceNum {
			case 1...9:		// Weapon in Armory
				if choiceNum 	<= weapons.displayed {
					let index	= weapons.currentIndex + choiceNum - 1
					teams[indexT].avatars[indexA].avatarWeaponUpdate(index)
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


// Choice -> Modify points allocation between profiles for a specific type (life, damage, care)
func pointsAllocations(_ type: Int)
{
	let inputType			= (type == 0 ? "Life" : (type == 1 ? "Damage" : "Care"))
	var inputCount			=	0			// Number of loops for full data entry
	var pointsShared		=	[0,0,0]	// Allocations values for the 3 avatars
	while inputCount		!= 3 {
		print("\n Enter the number of \(inputType) points for profile\(inputCount+1) and press 􀅇: ", terminator:"")
		if let input			= readLine() {
			let input			= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if let inputNum	= Int(input) {
				switch inputNum {
					case ...(-1):
						print("\n Value can't be negative! Pres any key to continue: ", terminator:"")
						let _ 	= getKeyPress()
					case 0:
						if type == 0 {
							print("\n You must at leat give 1 life points to the profile! Pres any key to continue: ", terminator:"")
							let _ = getKeyPress()
						} else {
							pointsShared[inputCount]	= inputNum
							inputCount						+= 1
						}
					default:
						pointsShared[inputCount]	= inputNum
						if pointsShared.reduce(0, +) > 999 {
							print("\n The total of \(inputType) points can't be greater than 999! Pres any key to continue: ", terminator:"")
							let _ 		= getKeyPress()
						} else {
							inputCount	+= 1
						}
				}
				if inputCount == 3 {
					game.gamePointsUpdate(type, pointsShared)
				}
			} else {
				print("\n Input canceled! Press any key to continue: ", terminator:"")
				let _			= getKeyPress()
				inputCount	= 3		// To escape from the while loop
			}
		}
	}
}

// Choice -> Modify extraChance
func gameExtra()
{
	var inputCount		=	0
	var extra			=	[0,0,0]
	while inputCount	!= 3 {
		if inputCount	== 0 {
			print("\n Enter a percentage value (0..99) defining the probability to have an extra offer and press 􀅇: ", terminator:"")
		} else {
			print("\n Enter the \(inputCount == 1 ? "minimum" : "maximum") of points (0..99) that can be added or deducted by an extra offer and press 􀅇: ", terminator:"")
		}
		if let input 		= readLine() {
			let input		= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count == 0 {
				print("\n Input canceled! Press any key to continue: ", terminator:"")
				let _ 		= getKeyPress()
				inputCount	= 3
			} else if let inputNum	= Int(input) {
				if inputNum		> 0 && inputNum <= 99 {
					extra[inputCount]	=	inputNum
					inputCount			+= 1
					if inputCount		== 3 {
						game.gameExtraUpdate(extra)
					}
				} else {
					print("\n Range of value is: 1...99. Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
				}
			}
		}
	}
}

// Choice -> Modify the cost in life points for each care
func gameCareCount() {
	var status				= true
	while status {
		print("\n Enter the cost of care in life points for the donor (0 = no cost) and press 􀅇: ", terminator:"")
		if let input 		= readLine() {
			let input 		= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count	== 0 {
				print("\n Input canceled! Press any key to continue: ", terminator:"")
				let _			= getKeyPress()
				status		= false
			} else if let inputNum	= Int(input) {
				if inputNum < 0 || inputNum > 99  {
					print("\n Range of value is: 0...99. Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
				} else {
					game.careCostUpdate(inputNum)
					status	= false
				}
			}
		}
	}
}
