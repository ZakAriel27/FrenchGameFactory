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
	print(" 􀂒────────────────────────────────────────────────────────􀂒  ╔══c══c══c══c══c══c══c══c══c═╗")
	print(" │ 􀂴uit                      GAME SETTINGS           􀂢elp │  ║ PLAY  􀂠AME  􀂸imulator  ▶▶▶")
	print(" 􀂒────────────────────────────────────────────────────────􀂒  ╚══c══c══c══c══c══c══c══c══c═╝")
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
	print(" │ 􀃘 \(armoury[7])  │  │ 􀃖 \(team2[1]) │   │ Care 􀂬ode: \(setting[6]) │")
	print(" │ 􀑷 \(armoury[8])  │  │ 􀃘 \(team2[2]) │   │ 􀂺urn mode: \(setting[7])  │")
	print(" 􀂒────────────────􀂒  􀂒──────────────────────────────────􀂒  􀂒───────────────────────────􀂒")
	if helpMode {
		helps.helpDisplay(1)
	}
}

//┌────────────────────────────────────────────────────┐
//│                   Game Parameters                  │
//└────────────────────────────────────────────────────┘

// Main loop
func gameSettings()
{
	weapons.weaponsInitList()	// Init index of the weapons list
	var status		= true		// Flag to exit the loop
	var visible		= false		// Flag to refresh the screen
	while status {
		if !visible {
			displayGameParameters()
			visible	= true
		}
		print("\n Press 􀃊..􀃘 to modify the teams or 􀂪􀂚􀂘􀂜􀂬􀂺 to modify the setting or 􀂠􀂸 to play : ", terminator:"")
		let choiceNum	= getKeyPress()
		if [1,2,3,4,5,6,7,8,99,100,101,103,104,108,109,113,115,116].contains(choiceNum) {
			switch choiceNum {
				case 1,5:					// Teams name
					teamInput(choiceNum)
				case 2,3,4: 			// Team1 Avatars
					teamInput(1, choiceNum)
				case 6,7,8: 			// Team2 Avatars
					teamInput(5, choiceNum)
				case 99: 			// Care Points
					pointsAllocations(2)
				case 100: 			// Damage Points
					pointsAllocations(1)
				case 101: 			// Extra Chance
					gameExtra()
				case 104: 			// Help
					helpMode	= !helpMode
				case 108: 			// Life Points
					pointsAllocations(0)
				case 109: 			// Care Mode
					gameCareCount()
				case 103: 			// Play Game
					Game.mode		= 0
					functionLink	= .play
					status			= false
				case 113:				// Quit
					functionLink	= .none
						status			= false
				case 115: 			// Play Simulator
					Game.mode		= 1
					functionLink	= .play
					status			= false
				case 116: 			// Turn Mode
					game.turnModeUpdate()
				default:
					break
			}
			visible	= false
		}
	}
}

//┌────────────────────────────────────────────────────┐
//│              Game Parameters functions             │
//└────────────────────────────────────────────────────┘

// Choice -> Modify Team or Avatar's name
func teamInput(_ choiceT: Int, _ choiceA: Int = -1)
{
	let indexT			= choiceT == 1 ? 0 : 1					// Team index
	let indexA			= choiceA - (indexT == 0 ? 2 : 6)	// convert choice (2..6) to index depending on team choosen
	var status			= true
	while status {
		let labeName	= indexA < 0 ? "Team \(indexT+1)" : "Avatar \(choiceA)"
		print("\n Enter a name for \(labeName) and press 􀅇: ", terminator:"")
		if let input	= readLine() {
			let input	= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count		 == 0 {
				print(" Input canceled! Press any key to continue: ", terminator:"")
				let _		= getKeyPress()
				status	= false
			} else {
				var test			= true
				let (team, avatar)	= teams[indexT].nameDouble(input)
				if team	== indexT && (avatar != indexA) {
					print("\n This name is already used in your team! Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
					test		= false
				} else if team == (indexT+1) % 2 {
					print("\n This name is already used by the other team! Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
					test		= false
				}
				if test == true {
					if indexA < 0 {
						teams[indexT].teamNameUpdate(input)
					} else {
						teams[indexT].avatars[indexA].avatarNameUpdate(input)
						weaponChoice(indexT, indexA)
					}
					status	= false
				}
			}
		}
	}
}

// Choice -> Choose Avatar's weapon in Armory
func weaponChoice(_ indexT: Int, _ indexA: Int)
{
	var status					= true
	while status {
		print("\n Press 􀃈..􀑷 to choose a weapon in the Armory (or 􀂮ext to see more weapons): ", terminator:"")
		let choiceNum			= getKeyPress()
		print()					// Go to next line after a getKeyPress()
		if [0,1,2,3,4,5,6,7,8,9,110].contains(choiceNum) {
			switch choiceNum {
			case 1...9:			// Weapon in Armory
				if choiceNum 	<= weapons.displayed {
					let index	= weapons.currentIndex + choiceNum - 1
					teams[indexT].avatars[indexA].avatarWeaponUpdate(index)
					status		= false
				}
			case 110:			// Next weapons from the armory
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
	let inputType				= (type == 0 ? "Life" : (type == 1 ? "Damage" : "Care"))
	var inputCount				=	0			// Number of loops for full data entry
	var pointsShared			=	[0,0,0]	// Allocations values for the 3 avatars
	while inputCount			!= 3 {
		print("\n Enter the number of \(inputType) points for Profile\(inputCount+1) and press 􀅇: ", terminator:"")
		if let input			= readLine() {
			let input			= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if let inputNum	= Int(input) {
				switch inputNum {
					case ...(-1):
						print(" Value can't be negative! Press any key to continue: ", terminator:"")
						let _ 	= getKeyPress()
					case 0:
						if type	== 0 {
							print(" You must at least give 1 life points to each profile! Press any key to continue: ", terminator:"")
							let _	= getKeyPress()
						} else if (type 	== 1 && game.pointsShared[inputCount][2] == 0) || (type 	== 2 && game.pointsShared[inputCount][1] == 0) {
							let inputType2	= type == 1 ? "Care" : "Damage"
							print(" The profile can't have 0 \(inputType2) point and  0 \(inputType) points! Press any key to continue: ", terminator:"")
							let _ = getKeyPress()
						} else if inputCount == 2 && pointsShared.reduce(0, +) == 0  {
							print(" One profile must at least have \(inputType) points! Press any key to continue: ", terminator:"")
							let _ = getKeyPress()
						} else {
							pointsShared[inputCount]	= inputNum
							inputCount						+= 1
						}
					default:
						pointsShared[inputCount]		= inputNum
						if pointsShared.reduce(0, +) > 999 - inputCount {
							print(" The total of \(inputType) points can't be greater than 999! Press any key to continue: ", terminator:"")
							let _ 		= getKeyPress()
						} else {
							inputCount	+= 1
						}
				}
				if inputCount == 3 {
					game.gamePointsUpdate(type, pointsShared)
				}
			} else {
				print(" Input canceled! Press any key to continue: ", terminator:"")
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
			print("\n Enter the \(inputCount == 1 ? "minimum" : "maximum") of points (1..99) that can be added or deducted by an extra offer and press 􀅇: ", terminator:"")
		}
		if let input 		= readLine() {
			let input		= input.trimmingCharacters(in: .whitespacesAndNewlines)
			if input.count == 0 {
				print(" Input canceled! Press any key to continue: ", terminator:"")
				let _ 		= getKeyPress()
				inputCount	= 3
			} else if let inputNum	= Int(input) {
				if inputNum 			== 0 && inputCount == 0 {
					game.gameExtraUpdate(extra)
					inputCount			= 3
				}
				if inputNum		> 0 && inputNum <= 99 {
					extra[inputCount]	=	inputNum
					inputCount			+= 1
					if inputCount		== 3 {
						game.gameExtraUpdate(extra)
					}
				} else {
					print(" Range of value is: 1...99.", terminator:"")
				}
			} else {
				print(" A numerical value is expected!", terminator:"")
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
				print(" Input canceled! Press any key to continue: ", terminator:"")
				let _			= getKeyPress()
				status		= false
			} else if let inputNum	= Int(input) {
				if inputNum < 0 || inputNum > 99  {
					print(" Range of value is: 0...99. Press any key to continue: ", terminator:"")
					let _		= getKeyPress()
				} else {
					game.careCostUpdate(inputNum)
					status	= false
				}
			}
		}
	}
}
