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
	let t1Play		= (currentTeam == 0 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t2Play		= (currentTeam == 1 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t1Name		= String(String(teams[0].name + space).prefix(12))
	let t2Name		= String(String(teams[1].name + space).prefix(12))
	let t1Life		= String(String(String(teams[0].lifePoints) + space).prefix(3))
	let t2Life		= String(String(String(teams[1].lifePoints) + space).prefix(3))
	let round		= String(String(String(currentRound) + "  ").prefix(3))

	// Array of fixed lenght avatars's names + information for the current team
	let t1A 		= teams[0].teamAvatarsNWDCList()
	let t2A 		= teams[1].teamAvatarsNWDCList()

	// Array of avatars's life points remaining in fixed lenght
	let t1L		= teams[0].teamAvatarsLifeList()
	let t2L		= teams[1].teamAvatarsLifeList()

	screenRefresh()
	// 􀎖􀎖􀎖 Display à mettre dans une liste comme pour les autres affichages
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
	print("\n")
	print("\n")
}

//┌────────────────────────────────────────────────────┐
//│                 Game Initialization                │
//└────────────────────────────────────────────────────┘

func newGameInit()
{
	// Armoury Initialization
	weaponsIndex				= 0			// Index in the weapons corresponding to the first displayed
	weaponsNextIndex			= 0			// Next Index in the weapons array for next display
	weaponsfirstDisplayed	= 0			// Index in the weapons array corresponding to the first displayed
	weaponsCountDisplayed	= 0			// Count of weapons currently displayed (to check choice)
	
	// Teams Initialization
	teams[0].teamGameInit(game)			// Team points and avatars points initialization
	teams[1].teamGameInit(game)			// Idem
	
	// Game Initialization
	//newGame						= false		//	Game in progress
	currentRound				= 1			// Current round
	currentTeam					= 0			// Current team playing
	currentAvatar1				= 0			// Current avatar playing
	currentAvatar2				= 0			//	Current avatar receiving
	rounds						= [Round]()	// Clear rounds log

}

//┌────────────────────────────────────────────────────┐
//│                      Game Play                     │
//└────────────────────────────────────────────────────┘

func gamePlay()
{
	// Main loop
	functionLink = ""		// Erase last link to avoid side effects
	newGameInit()
	var status 			=	true
	var visible 		=	false
	var teamName		=	""
	var avatarName		=	""
	var inputCount		=	0
	while status {
		if !visible {
			displayGamePlay()
			visible = true
			if teams[0].lifePoints == 0 || teams[1].lifePoints == 0 {
				status = false		// To stop while status loop
				inputCount = 0		// To stop while inputCount loop
			}
		}
		teamName		= teams[currentTeam].name										// To be more readable
		avatarName	= teams[currentTeam].avatars[currentAvatar1].nickName	// Idem
		inputCount = (game.turnMode == true ? 0 : 1) + 2
		// 􀎖􀎖􀎖 Voir comment cela se passe en fin de partie
		// 􀎖􀎖􀎖 Traiter le cas des avatars morts qui ne peuvent plus être choisi, idem pour les rotations
		while inputCount != 0 {
			if inputCount == 3 {
				print("\(teamName)'s turn: choose your avatar (􀃊􀃌􀃎): ", terminator:"")
			} else if inputCount == 2 {
				print("\(teamName) \(avatarName)'s turn: choose your action key (􀂔/􀂘) and opponent/fellow (􀃊􀃌􀃎): ", terminator:"")
			}
			let choiceNum = getKeyPress()
			if [1,2,3,97,99,104,108,113].contains(choiceNum) {
				switch choiceNum {
					case 1,2,3:				// Avatar choice
						if inputCount == 3 {
							currentAvatar1 = choiceNum - 1
							inputCount -= 1
						} else if inputCount == 1 {
							currentAvatar2 = choiceNum - 1
							inputCount -= 1
							gamePlay2()
							visible = false
						}
					case 97:				// Action Attack
						if inputCount == 2 {
							currentAction = Actions.attack
							inputCount -= 1
						}
					case 99:				// Action Care
							if inputCount == 2 {
								currentAction = Actions.care
								inputCount -= 1
							}
					case 104:				// Help
						helps.helpDisplay(2)
					case 108:				// Display Log
						displayGamePlay()
						roundsLog()
						visible = false
						inputCount = 0
					case 113:				// Quit
							status = false
							inputCount = 0
					default:
						print("\nSeems we have a bug at gamePlay(). Press any key to continue: ", terminator:"")
						let _ = getKeyPress()
						inputCount = 0
				}
			} else {
				inputCount = 0				// Wrong input -> init loop of questions before asking again
			}
		}
		print()
	}
	displayGamePlay()
	displayRoundsLog()
	endGame()
}

//┌────────────────────────────────────────────────────┐
//│                  Game Play Functions               │
//└────────────────────────────────────────────────────┘

func gamePlay2()
	// Choice processing
{
	print()																// Changing line after last valid input
	let team1 				= teams[currentTeam]					// To be more readable
	let avatar1				= team1.avatars[currentAvatar1]	// Idem
	let team2 				= currentAction == .care ? teams[(currentTeam)] : teams[(currentTeam+1) % 2]	// Idem
																			// if action = care Team2 = Team1 else Team2 = (currentTeam+1) % 2
	let avatar2				= team2.avatars[currentAvatar2]	// Idem
	var engagedPoints		= 0										// Points engaged for the round
	if currentAction 		== .attack {
		engagedPoints 	= 	(min(avatar2.aPoints[0],avatar1.aPoints[1] )) // Points to be deducted can't be > recipient's life points
		avatar2.avatarLifeUpdate(-engagedPoints)
		team2.teamLifeUpdate(-engagedPoints)
		if avatar2.aPoints[0] == 0 {
			print()
			print("\(avatar2.nickName) has no more life points: † R.I.P. †. Press any key to continue: ", terminator:"")
			let _ = getKeyPress()
		}
		if team2.lifePoints 	<= 0 {
			team2.lifePoints 	= 0
		}
	} else {	// Care
		if game.careMode {
			engagedPoints = min(avatar1.aPoints[0],avatar1.aPoints[2] )		// Gained points can't be > donnor's life points
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			avatar1.avatarLifeUpdate(-engagedPoints)								//	Avatar's points decreases -> team's points equal
			
			if avatar1.aPoints[0]	== 0 {
				print()
				print("\(avatar1.nickName) has no more life points: † R.I.P. †. Press any key to continue: ", terminator:"")
				let _ = getKeyPress()
			}
		} else {
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			team1.teamLifeUpdate(engagedPoints)										// In this case team's life points increases
		}
	}
	// Recording of round data
	let avatarT1 = (currentTeam == 0 ? currentAvatar1 : currentAvatar2)
	let avatarT2 = (currentTeam == 1 ? currentAvatar1 : currentAvatar2)
	let t1Life	=	teams[0].lifePoints
	let t2Life	=	teams[1].lifePoints
	let t1ALife:	[Int]	= teams[0].teamAvatarsLife()
	let t2ALife:	[Int]	= teams[1].teamAvatarsLife()
	
	rounds.append(Round(currentRound, currentTeam, avatarT1, avatarT2, currentAction, engagedPoints, 0, -1, t1Life, t2Life, t1ALife, t2ALife))
	


	if teams[0].lifePoints != 0 && teams[1].lifePoints != 0 {
		// Initialization for the next round
		if game.turnMode	&& currentTeam == 1 {			// Each team has played
			currentAvatar1	= (currentAvatar1 + 1) % 3		// -> Need to change avatar's number in rotation mode
		}
		currentRound	+=	1										// Init for the next round
		currentTeam		= (currentTeam + 1) % 2				// Swap current team
	}
}

func endGame()
{
	print()
	if teams[currentTeam].lifePoints != 0 {
		print("Game cancelled!")
	} else {
		print("Team \(teams[currentTeam].name) wins! ")
	}
	print()

	print("Press any key to return to the Main Menu: ", terminator:"")
		let _ = getKeyPress()
}

