	asect 0x00
start:
	setsp 0xaf
	#spawn apple at the start
	jsr spawn_apple
readkbd:
#work with head
	#input direction
	ldi r2, 0xee
	ld r2, r2
	#save direction to memory
	jsr load_direction_to_mem
	#move tail coords
	ldi r3, 0xfa
	st r3, r2
	#start sel reg to 0
	ldi r3, 0xfd
	ldi r2, 0
	st r3, r2
	if
		ldi r3, 0xef
		ld r3, r3
		tst r3
	is nz
		jsr spawn_apple
		br readkbd # Go back to the start
	fi	
#work with tail
	#start sel reg to 1
	ldi r3, 0xfd
	ldi r2, 1
	st r3, r2
	#start sel reg to 0
	ldi r3, 0xfd
	ldi r2, 0
	st r3, r2
	#input direction
	jsr take_direction_from_mem
	ldi r2, 0xfb
	st r2, r3

	br readkbd # Go back to the start
	spawn_apple: # function to spawn apple
		#we nead new apple
		ldi r3, 0xfc
		ldi r2, 1
		st r3, r2
		ldi r3, 0xfc
		ldi r2, 0
		st r3, r2
		#start sel reg to 2
		ldi r3, 0xfd
		ldi r2, 2
		st r3, r2
		rts
	load_direction_to_mem:
		#r0 - head X
		#r1 - head Y
		#r2 - direction
		#save to stack
		#move r0, r3
		#ldi r3, 0xe8
		#ld r3, r3
		#push r0
		#push r1
		push r2
		# 1
		#shra r0
		#shra r0
		# 2
		#shla r1
		#shla r1
		#shla r1
		#shla r1
		# 3
		#or r0, r1
		ldi r1, 0xe6
		ld r1, r1
		#4
		#ld r1, r0
		#5 
		#ldi r0, 0x03
		#and r3, r0
		#ldi r3, 0x03
		#sub r3, r0
		#push r0
		#6
		#ldi r3, 0x03
		#while
			#tst r0
		#stays nz
			#shla r3
			#shla r3
			#dec r0
		#wend
		ldi r3, 0xea
		ld r3, r3
		#7
		not r3
		#8
		ld r1, r0
		and r3, r0
		#9
		#pop r3
		#while
		#	tst r3
		#stays nz
		#	shla r2
		#	shla r2
		#	dec r3
		#wend
		ldi r2, 0xec
		ld r2, r2
		#10
		or r2, r0
		#11
		st r1, r0
		#take from stack
		pop r2
		#pop r1
		#pop r0
		rts
	take_direction_from_mem:
		#r0 - tail X
		#r1 - tail Y
		#r2 - direction
		#save to stack
		#ldi r3, 0xe9
		#ld r3, r3
		#move r0, r3
		#push r0
		#push r1
		# 1
		#shra r0
		#shra r0
		# 2
		#shla r1
		#shla r1
		#shla r1
		#shla r1
		# 3
		#or r0, r1
		ldi r1, 0xe7
		ld r1, r1
		#4
		#ld r1, r0
		#5 
		#ldi r0, 0x03
		#and r3, r0
		#ldi r3, 0x03
		#sub r3, r0
		#push r0
		#6
		#ldi r3, 0x03
		#while
			#tst r0
		#stays nz
			#shla r3
			#shla r3
			#dec r0
		#wend
		ldi r3, 0xeb
		ld r3, r3
		#7
		ld r1, r0
		and r0, r3
		#8
		#pop r0
		ldi r2, 0xfe
		st r2, r3 
		#while
		#	tst r0
		#stays nz
		#	shr r3
		#	tst r0
		#	shr r3
		#	tst r0
		#	dec r0
		#wend
		ldi r3, 0xed
		ld r3, r3
		#move r3 to r2
		#move r3, r2
		#take from stack
		#pop r1
		#pop r0
		rts
end
