	asect 0x00
#---------------------
# start
start:
	setsp 0xaf
	#spawn apple at the start
	jsr spawn_apple
	#move head
	jsr move_head
	#start sel reg to 1
	ldi r3, 0xfd
	ldi r2, 1
	st r3, r2
	#change screen to game screen
	ldi r3, 0xf9
	ldi r2, 1
	st r3, r2
#-----------------------
#         main
main:
#work with head
	jsr move_head
#work with tail
	jsr move_tail
# Go back to the start
	br main
##--------------------------------
#             functions
	move_head: # function to move head
		#input direction
		ldi r2, 0xee
		ld r2, r2
		#save direction to memory
		jsr load_direction_to_mem
		#move head coords
		ldi r3, 0xfa
		st r3, r2
		# check if apple is eaten
		if	
			#request to logisim
			ldi r3, 0xef
			ld r3, r3
			tst r3
		is nz #if apple is eaten
			jsr spawn_apple
			br move_head # Go back to the start
		else
			#check for crash
			ldi r3, 0xff
			ldi r2, 1
			st r3, r2
			ldi r3, 0xff
			ldi r2, 0
			st r3, r2
		fi
		#paint pixel with new coords
		#start sel reg to 0
		ldi r3, 0xfd
		ldi r2, 0
		st r3, r2
		rts
	move_tail:
		#input direction
		jsr take_direction_from_mem
		# move tail cords
		ldi r2, 0xfb
		st r2, r3
		#turn off pixel with tail
		#start sel reg to 1
		ldi r3, 0xfd
		ldi r2, 1
		st r3, r2
		rts
	spawn_apple: # function to spawn apple
		#request to logisim to generate new coords
		ldi r3, 0xfc
		ldi r2, 1
		st r3, r2
		ldi r3, 0xfc
		ldi r2, 0
		st r3, r2
		#paint pixel with apple
		#start sel reg to 2
		ldi r3, 0xfd
		ldi r2, 2
		st r3, r2
		rts
	load_direction_to_mem:
		#r2 - direction
		#save to stack
		push r2
		#ask logisim addres in memory
		ldi r1, 0xe6
		ld r1, r1
	# save coords to memory line
		#delete direction in cell
		ldi r3, 0xea
		ld r3, r3
		# invert
		not r3
		# and to del old direction
		ld r1, r0
		and r3, r0
		# move direction to correct place
		ldi r2, 0xec
		ld r2, r2
		# save to the data line
		or r2, r0
		# save to RAM
		st r1, r0
		#take from stack
		pop r2
		rts
	take_direction_from_mem:
		#ask logisim addres in memory
		ldi r1, 0xe7
		ld r1, r1
		#take direction from data line
		ldi r3, 0xeb
		ld r3, r3
		#with and delete extra data in line
		ld r1, r0
		and r0, r3
		#load data line to logisim
		ldi r2, 0xfe
		st r2, r3 
		#load direction for tail
		ldi r3, 0xed
		ld r3, r3
		rts
end
