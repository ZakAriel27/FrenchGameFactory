//
//  GamePlay.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

//┌────────────────────────────────────────────────────┐
//│                  Display Game Play                 │
//└────────────────────────────────────────────────────┘

func displayGamePlay()
{
	// As display is in monospaced font, all values must be formated in fixed lenght
	let space		= String(repeating: " ", count: 16)

	// Properties converted to fixed-length strings
	let t1Play		= (currentT1 == 0 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t2Play		= (currentT1 == 1 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t1Name		= String(String(teams[0].name + space).prefix(12))
	let t2Name		= String(String(teams[1].name + space).prefix(12))
	let t1Life		= String(String(String(teams[0].lifePoints) + space).prefix(3))
	let t2Life		= String(String(String(teams[1].lifePoints) + space).prefix(3))
	let round		= String(String(String(currentRound) + "  ").prefix(3))

	// Array of fixed lenght avatars's names + information for the current team
	let t1A 			= teams[0].teamAvatarsNWDCList()
	let t2A 			= teams[1].teamAvatarsNWDCList()

	// Array of avatars's life points remaining in fixed lenght
	let t1L			= teams[0].teamAvatarsLifeList()
	let t2L			= teams[1].teamAvatarsLifeList()

	screenRefresh()
	print()
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒" )
	print("│ 􀂴uit  \(t1Play)    │ Round \(round)│ view 􀂪og │  \(t2Play)  􀂢elp │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print("│ Team1: \(t1Name)                  \(t1Life) │ 􀝶 │ Team 2: \(t2Name)               \(t2Life)  │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print("│ 􀂒 Avatars                          Lives │  │ 􀂒 Avatars                          Lives │")
	print("│ 􀃊 \(t1A[0]) │  \(t1L[0])  │  │ 􀃊 \(t2A[0]) │  \(t2L[0])  │")
	print("│ 􀃌 \(t1A[1]) │  \(t1L[1])  │  │ 􀃌 \(t2A[1]) │  \(t2L[1])  │")
	print("│ 􀃎 \(t1A[2]) │  \(t1L[2])  │  │ 􀃎 \(t2A[2]) │  \(t2L[2])  │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
}

//┌────────────────────────────────────────────────────┐
//│                 Game Initialization                │
//└────────────────────────────────────────────────────┘

func newGameInit()
{
	// Armoury Initialization
	weaponsIndex				= 0			// Index in the weapons corresponding to the first displayed
	weaponsNextIndex			= 0			// Next Index in the weapons array for next display
	weaponsfirstDisplayed	= 0			// Index in the weapons struct corresponding to the first displayed
	weaponsCountDisplayed	= 0			// Count of weapons currently displayed (to check choice)
	
	// Teams Initialization
	teams[0].teamGameInit(game)			// Team points and avatars points initialization
	teams[1].teamGameInit(game)			// Idem
	currentA1				= 0			// Current avatar playing
	
	// Game Initialization
	currentRound				= 1			// Current round
	currentT1					= 0			// Current team playing
	teamTurn						= [0,0]		// Avatar to play for each team (dead avatars taken into account)
	teamHealth					= [9,9]		// Avatars' health number
	rounds						= [Round]()	// Clear rounds log

}

//┌────────────────────────────────────────────────────┐
//│                      Game Play                     │
//└────────────────────────────────────────────────────┘

func gamePlay()
{
	// Main loop
	newGameInit()
	var status			=	true		// Flag for first while loop
	var visible			=	false		// Flag need to refresh the display
	var inputCount		=	0			// Number of runs required in the while loop to collect all data
	while status {
		if teams[0].lifePoints == 0 || teams[1].lifePoints == 0 {
			break
		}
		if !visible {
			displayGamePlay()
			visible 		= true
		}
		let teamName		= teams[currentT1].name										// To be more readable
		inputCount 			= game.turnMode == true ? 1 : 0
		while inputCount != 3 {
			if inputCount == 0 {
				print("\nTeam \(teamName) to play: choose your avatar (\(keyDisplay[teamHealth[currentT1]])): ", terminator:"")
			} else if inputCount	== 1 {
				let avatarName	= teams[currentT1].avatars[currentA1].nickName	// To be more readable
				print("\nIt's up to the avatar \(avatarName) from \(teamName) to play:")
				if [1,3,5].contains(teamHealth[currentT1]) {		// The current team has only one avatar left
					inputCount = 2		// Skips the choice of action as care is not possible
				print("\nChoose the opponent to attack (\(keyDisplay[teamHealth[(currentT1+1) % 2]])): ", terminator:"")
				} else {
					print("\nChoose your action key (􀂔/􀂘) and opponent (\(keyDisplay[teamHealth[(currentT1+1) % 2]])) or fellow (\(keyDisplay[teamHealth[currentT1]-(1+(2*currentA1))])): ", terminator:"")
						// Need to subtract the playing avatar from the avatars available for care
				}
			}
			let choiceNum = getKeyPress()
			if [1,2,3,97,99,104,108,113].contains(choiceNum) {
				switch choiceNum {
					case 1,2,3:		// Avatar choice
						if inputCount == 0  && keyGroup.contains(String(choiceNum-1)+String(teamHealth[currentT1])) {
							currentA1 	= choiceNum - 1
							inputCount			+= 1
						} else if inputCount == 2 && keyGroup.contains(String(choiceNum-1)+String(teamHealth[currentAction == .attack ? (currentT1+1)%2 : currentT1])) {
							currentA2 	= choiceNum - 1
							inputCount	+= 1
							gamePlay2()
							visible		= false
						}
					case 97:			// Action Attack
						if inputCount == 1 {
							currentAction	= Actions.attack
							inputCount		+= 1
						}
					case 99:			// Action Care
						if inputCount == 1 {
							currentAction	= Actions.care
							inputCount 		+= 1
						}
					case 104:		// Help
						displayGamePlay()
						helps.helpDisplay(2)
					case 108:		// Display Log
						roundsLog()
						visible			= false
						inputCount		= 3
					case 113:		// Quit
							status		= false
							inputCount	= 3
					default:
						break
				}
			} else {
				inputCount	= game.turnMode == true ? 1 : 0	// Wrong input -> init loop of questions before asking again
			}
		}
	}
	// Exit of the input loop -> game finished or canceled
	displayGamePlay()
	displayRoundsLog()
	gameEnd()
}

//┌────────────────────────────────────────────────────┐
//│                  Game Play Functions               │
//└────────────────────────────────────────────────────┘

func gamePlay2()
	// Choice processing
{
	let team1 					= teams[currentT1]					// To be more readable
	let team2 					= currentAction == .care ? teams[(currentT1)] : teams[(currentT1+1) % 2]	// Idem
	// if action = care Team2 = Team1 else Team2 = (currentTeam+1) % 2
	let avatar1					= team1.avatars[currentA1]	// Idem
	let avatar2					= team2.avatars[currentA2]	// Idem
	var extraAnswer			= -1										// -1: no offer, 0: No, 1: Yes
	var extraPoints			= 0										// Number of points to add or remove
	var engagedPoints			= 0										// Points engaged for the round
	if currentAction == .attack {
		let randomValue 		= Int.random(in:1...100)
		if randomValue <= game.extraChance {
			extraPoints			= game.extraPoints * (Int.random(in: 0...1) == 1 ? 1 : -1)
			var status 			= true
			while status {
				print("\n\nYou have an offer to change the power of your weapon. Do you accept it? (􀃄 or 􀂮): ", terminator:"")
				let choiceNum 	= getKeyPress()
				if [110,121].contains(choiceNum) {
					if choiceNum == 121 {			// Yes
						extraAnswer		= 1
						print("\n\(extraPoints>0 ? "Great!" : "Damn!") Your weapon has \(extraPoints>0 ? "gained" : "lost") \(extraPoints) points. It has now \(avatar1.aPoints[1]+extraPoints) points of destruction. Press any key to continue: ", terminator:"")
						let _	= getKeyPress()
					} else {
						extraAnswer	= 0
					}
					status = false
				}
			}
		}
		// Points to be deducted can't be more than opponent life points
		engagedPoints 	= 	min(avatar2.aPoints[0],avatar1.aPoints[1]+(extraAnswer == 1 ? extraPoints : 0))
		avatar2.avatarLifeUpdate(-engagedPoints)
		team2.teamLifeUpdate(-engagedPoints)
		if avatar2.aPoints[0] == 0 {
			teamHealth[(currentT1+1) % 2] -= 2 * currentA2 + 1	// Deducts the prime number linked to the avatar
			print("\n\n\(String(repeating: "† ", count: 40))")
			print("\n\(avatar2.nickName) has no more life points: † R.I.P. †. Press any key to continue: ", terminator:"")
			let _						= getKeyPress()
		}
		if team2.lifePoints 		<= 0 {
			team2.lifePoints 		= 0
		}
	} else {	// Care
		if game.careMode {
			engagedPoints			= min(avatar1.aPoints[0],avatar1.aPoints[2] ) // Gained points can't be > donnor's life points
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			avatar1.avatarLifeUpdate(-engagedPoints)								//	Avatar's points decreases -> team's points equal
			if avatar1.aPoints[0] == 0 {
				teamHealth[currentT1]	-= 2 * currentA1 + 1						// Deducts the prime number linked to the avatar
				print("\n\n\(String(repeating: "† ", count: 40))")
				print("\n\(avatar1.nickName) has no more life points: † R.I.P.†. Press any key to continue: ", terminator:"")
				let _					= getKeyPress()
			}
		} else {
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			team1.teamLifeUpdate(engagedPoints)										// In this case team's life points increases
		}
	}
	// Recording of round data
	let avatarT1	= (currentT1 == 0 ? currentA1 : currentA2)
	let avatarT2	= (currentT1 == 1 ? currentA1 : currentA2)
	let t1Life		=	teams[0].lifePoints
	let t2Life		=	teams[1].lifePoints
	let t1ALife:	[Int]	= teams[0].teamAvatarsLife()
	let t2ALife:	[Int]	= teams[1].teamAvatarsLife()
	
	rounds.append(Round(currentRound, currentT1, avatarT1, avatarT2, currentAction, engagedPoints, extraPoints, extraAnswer, t1Life, t2Life, t1ALife, t2ALife))
	
	if teams[0].lifePoints != 0 && teams[1].lifePoints != 0 {
		// Initialization for the next round
		currentRound		+=	1							// Init for the next round
		currentT1			= (currentT1+1) % 2		// Swap current team
		if game.turnMode {
			if (currentT1 == 0) {						// Rotation mode & again team1 -> need to change Avatars to play
				//print("curent: \(currentT1) teamTurn: \(teamTurn)  teamHealth: \(teamHealth)")
				teamTurn[0] 			= (teamTurn[0] + 1) % 3		// Updates teamTurn for team1
				while !keyGroup.contains(String(teamTurn[0])+String(teamHealth[0])) {
					teamTurn[0] 		= (teamTurn[0] + 1) % 3
				}
				currentA1 = teamTurn[0]									// Update currentA1 with new teamTurn[0]
				teamTurn[1] 			= (teamTurn[1] + 1) % 3		// Updates teamTurn for team2
				while !keyGroup.contains(String(teamTurn[1])+String(teamHealth[1])) {
					teamTurn[1] 		= (teamTurn[1] + 1) % 3
				}
			} else {
				//print("curent: \(currentT1) teamTurn: \(teamTurn)  teamHealth: \(teamHealth)")
				//The avatar to be played may have died during the previous turn.
				while !keyGroup.contains(String(teamTurn[currentT1])+String(teamHealth[currentT1])) {
					teamTurn[currentT1]	=	(teamTurn[currentT1] + 1) % 3
				}
				currentA1 = teamTurn[1]
			}
		//print("curent: \(currentT1) teamTurn: \(teamTurn)  teamHealth: \(teamHealth)")
		//let _ = getKeyPress()
		}
	}
}

func gameEnd()
{
	// This function manages the endgame according to different situations
	let space		= String(repeating: " ", count: 80)	// lenght for formated strings
	var status	=	true		// Flag to exit the loop
	print("\n\(String(repeating: "• ", count: 46))")
	if teams[0].lifePoints != 0 && teams[1].lifePoints != 0 {	// None of the team lost -> game canceled
		print("\n\(String(space + "Game cancelled!").suffix(90))")
	} else {
		print("\n\(String(space + "Team " + teams[currentT1].name + " wins. Congratulations!").suffix(90))")
	}
	print("\n\(String(repeating: "• ", count: 46))\n")
	while status {
		print("\nPress the key of your choice: 􀂲lay a new game, change the game 􀂸ettings or 􀂴uit: ", terminator:"")
		let choiceNum = getKeyPress()
		if [112,113,115].contains(choiceNum) {
			switch choiceNum {
				case 112:		// New game
					functionLink	= "Play"
				case 115:		// Game setting
					functionLink	= "Setting"
				case 113:		// Quit
					functionLink	= ""
				default:
					break
			}
			status	= false
		}
	}
}

