//
//  Introduction.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 29/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

func introduction()
{
	screenRefresh()
	let helpList =	helps.helpList(0)
	//helps.helpDisplay(0)
	for index in 0...helpList.count - 1 {
		print(helpList[index])
		if index == 9 || index == 19 {
			print("\nPress any key to continue: ", terminator: "")
			for _ in 1...5 {
				print()
			}
			let _ = getKeyPress()
			screenRefresh()
		}
	}
	print()
}

