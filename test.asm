	asect 0x00
start:
	setsp 0xef
readkbd:
	#set stop=1
	ldi r3, 0xf1
	ldi r2, 1
	st r3, r2
#work with head
	#save direction to matrix
	ldi r0, 0xff # input coords in memory
	ld r0, r0
	
	ld r0, r1 #load directions line
	
	#input x_head
	ldi r0, 0xf8
	ld r0, r0
	#input y_head
	ldi r1, 0xf9
	ld r1, r1
	#input direction
	ldi r2, 0xfe
	ld r2, r2
	#move tail coords
	jsr change_coords
	push r2
	#set value=1
	ldi r3, 0xf0
	ldi r2, 1
	st r3, r2
	#set stop=0
	ldi r3, 0xf1
	ldi r2, 0
	st r3, r2
	#put data X_head and Y_head
	ldi r3, 0xf2
	st r3, r0
	
	ldi r3, 0xf3
	st r3, r1
	#set value=0
	ldi r3, 0xf0
	ldi r2, 0
	st r3, r2
	#set stop=1
	ldi r3, 0xf1
	ldi r2, 1
	st r3, r2
#work with tail
	#set value=0
	ldi r3, 0xf0
	ldi r2, 0
	st r3, r2
	#set stop=0
	ldi r3, 0xf1
	ldi r2, 0
	st r3, r2
	#set stop=1
	ldi r3, 0xf1
	ldi r2, 1
	st r3, r2
	#input x_tail
	ldi r0, 0xfa
	ld r0, r0
	#input y_tail
	ldi r1, 0xfb
	ld r1, r1
	#input direction
	pop r2
	
	#move tail coords
	jsr change_coords
	
	#put data X_tail and Y_tail
	ldi r3, 0xf4
	st r3, r0
	
	ldi r3, 0xf5
	st r3, r1
	
	br readkbd # Go back to the start
	
	
	#function to move coords
	change_coords:
		#move tail up
		if
			ldi r3, 0b00000000
			cmp r2, r3
		is z
			dec r1
		fi
		#move tail down
		if
			ldi r3, 0b00000001
			cmp r2, r3
		is z
			inc r1
		fi
		#move tail left
		if
			ldi r3, 0b00000010
			cmp r2, r3
		is z
			dec r0
		fi
		#move tail rigth
		if
			ldi r3, 0b00000011
			cmp r2, r3
		is z
			inc r0
		fi
		rts
end
