/datum/looping_sound/effector_vaper
	start_sound = 'sound/machines/shower/shower_start.ogg'
	start_length = 2
	mid_sounds = list('sound/machines/shower/shower_mid1.ogg'=1,'sound/machines/shower/shower_mid2.ogg'=1,'sound/machines/shower/shower_mid3.ogg'=1)
	mid_length = 10
	end_sound = 'sound/machines/shower/shower_end.ogg'
	volume = 10

/obj/machinery/effector
	name = "парилка"
	desc = "Парит. Гы."
	icon = 'code/shitcode/valtos/icons/effector.dmi'
	icon_state = "effector"
	var/workout = TRUE
	var/workdir = "up"
	var/datum/looping_sound/effector_vaper/soundloop

/obj/machinery/effector/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/effector/process()
	if(workout)
		soundloop = new(list(src), TRUE)
		soundloop.start()
		workout = FALSE
	var/obj/effect/vaper_smoke/S = new(get_turf(src))
	switch(workdir)
		if("up")
			animate(S, pixel_y = 64, pixel_x = rand(-12, 12), transform = matrix()*2, alpha = 0, time = 40)
		if("down")
			animate(S, pixel_y = -64, pixel_x = rand(-12, 12), transform = matrix()*2, alpha = 0, time = 40)

/obj/effect/vaper_smoke
	name = "пар"
	alpha = 60
	layer = FLY_LAYER
	icon = 'code/shitcode/valtos/icons/effector.dmi'
	icon_state = "smoke"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/vaper_smoke/Initialize()
	. = ..()
	spawn(80)
		qdel(src)
