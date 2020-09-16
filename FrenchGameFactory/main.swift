//
//  main.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//
//
import Foundation

// Help Topics
//https://stackoverflow.com/questions/25551321/xcode-swift-command-line-tool-reads-1-char-from-keyboard-without-echo-or-need-to/25551523#25551523
// https://stackoverflow.com/questions/25483292/update-current-line-with-command-line-tool-in-swift A voir pour rester sur la même ligne
// https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift A voir pour jouer un son
// https://stackoverflow.com/questions/32750139/how-to-compare-one-value-against-multiple-values-swift Used to compare several values in one instruction
//https://stackoverflow.com/questions/24024722/determine-if-a-range-contains-a-value usage of if case and range



//┌────────────────────────────────────────────────────┐
//│              Miscellaneous Functions               │
//└────────────────────────────────────────────────────┘

func getKeyPress() -> Int
{
	// Found this function the web to get a single character input.
	// I had to modify it to handle accented characters that generate two codes
	// Only the second code allows to distinguish the letters é è ç à on the numeric keys
	let c: cc_t 			= 0
	let cct					= (c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c) // Set of 20 Special Characters
	var oldt:	termios	= termios(c_iflag: 0, c_oflag: 0, c_cflag: 0, c_lflag: 0, c_cc: cct, c_ispeed: 0, c_ospeed: 0)
	
	tcgetattr(STDIN_FILENO, &oldt)			// 1473
	var newt					= oldt
	newt.c_lflag			= 1217  				// Reset ICANON and Echo off
	tcsetattr( STDIN_FILENO, TCSANOW, &newt)
	var key:		Int 		= 0
	key						= Int(getchar())  // works like "getch()"
	if key == 195 {								// Accented characters on the row of numeric keys (éèçà)
		key 					= Int(getchar())	// Distinctive part of the accented character
	}
	tcsetattr( STDIN_FILENO, TCSANOW, &oldt)
	return choiceConvert(key)			// Pascal: Add choiceConvert to simplify code
												// Accented letters return 2 codes. If input buffer is not clear the next getKeyPress will receive the second code before the user has even pressed a new key.
}


// Palette : 􀄌 􀄊 􀄋 􀁸 􀏃 􀑋 􀝶 􀀀 􀁴 􀙦 │ ─ 􀃊 􀃌 􀃎 􀘙 􀃒 􀑵 􀃖 􀃘 􀑷 􀂔 􀂘 􀂚 􀂠 􀂢 􀂨 􀂪 􀂬 􀂮 􀂲 􀂴 􀂶 􀂸 􀂺 􀃀 􀃂 􀃄


func choiceConvert(_ input: Int) -> Int
{
// This function returns a unique value from upper/lower case or numbers/characters on the same key. It simplifies input processing
	if let output	= inputConvert[input] {
		return 		output
	} else {
		return 		0
	}
}

func screenSizing()
{
	// This function helps to size the console to be in good conditions to use the application
	print("\nWellcome to the RPS Simulator! (by the French Game Factory)\n\n")
	print("\nBefore starting I need your help !")
	print("\n   - As the commands related to the screen refresh don't work under Xcode, I need your help to size the console to be in good conditions to use the application.")
	print("\n      When ready, press 􀅇 to continue.")
	let _ = readLine()
	print("- A rectangle will be displayed. Please size the console so that you can see all 4 sides (no more in height).")
	print("     Press 􀅇 to continue.")
	let _ = readLine()
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	for _ in 1...31 {
		print("│                                                                                         │")
	}
	print("􀂒──────────────────────────  When done, press 􀅇 to continue  ───────────────────────────􀂒")
	let _ = readLine()
	print("Tank's for you help. Program starts in 3 seconds ...")
	do {
		sleep(3)
	}
}

func screenRefresh() {
	// This function replaces the clear function, which is inactive from the console.
		print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
}

//┌────────────────────────────────────────────────────┐
//│    Objects and global variables Initialization     │
//└────────────────────────────────────────────────────┘
//										  0,à    1,&    2,é    3,"   4,'   5,(    6,§    7,è   8,!    9,ç
let inputConvert:	[Int: Int] = [48:0,  49:1,  50:2,  51:3, 52:4, 53:5,  54:6,  55:7, 56:8,  57:9,
										 160:0,  38:1, 169:2,  34:3, 39:4, 40:5, 194:6, 168:7, 33:8, 167:9,
//	A,a    C,c     D,d      E,e      H,h      L,l      M,m      N,n      P,p      Q,q      S,s      T,t      Y,y
	65:97, 67:99,  68:100,  69:101,  72:104,  76:108,  77:109,  78:110,  80:112,  81:113,  83:115,  84:116,  89:121,
//	Need to include lowercase letters to generalize the call of choiceConvert()
	97:97, 99:99, 100:100, 101:101, 104:104, 108:108, 109:109, 110:110, 112:112, 113:113, 115:115, 116:116, 121:121]

let screenSize	= 32																					// Sreen height after sizing the console

let keyDisplay	= ["","􀃊","","􀃌","􀃊􀃌","􀃎","􀃊􀃎","", "􀃌􀃎","􀃊􀃌􀃎"] 				// Strings to display team's living avatars
let keyGroup 	= ["01","04","06","09","13","14","18","19","25","26","28","29"]	// Strings to check if an avatar is alive
//
// Help Initialization
let helps 					= Help()				// Struct containing all help texts availables
let helpSection 			= HelpSection()	//Table of message groups to be displayed on demand

// Game Initialization
let game							= Game()			// instance containing the game setting and points counters
var teams 						= [Team]()		// Array containing the teams (2) with their avatars and weapons
var weapons 					= Weapons()		// Stuct containing all the weapons availables in the armory
var rounds						= [Round]()		// Array of round played

game.gameInit()									// Pre-loading game
var functionLink				= ""				// Used to manage the sequence of functions
var teamTurn					= [0,0]			// In rotation mode, allows to know the avatar to play for each team
														// taking into account the dead -> can be different according to the team.
var teamHealth					= [9,9]			// TeamHealth makes it possible to quickly test which avatars of a team
														// are alive without having to test each avatar separately.


//┌────────────────────────────────────────────────────┐
//│                    Program Start                   │
//└────────────────────────────────────────────────────┘


screenSizing()		// Console calibration step
mainMenu()			// Program start

