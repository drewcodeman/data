-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Enspell','Savage','Normal','blunt','Piercing','Tank','Arrow')
    state.HybridMode:options('Normal', 'Arrow', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
	
	Sucellos = {}
	Sucellos.Nuke = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	Sucellos.TP = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	Sucellos.WSD = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	Sucellos.MND = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	Sucellos.Crit = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
    Sucellos.DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Damage taken-5%',}}
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +3",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {    
	ammo="Staunch Tathlum",
    head="Carmine Mask +1",
    body="Viti. Tabard +3",
    hands={ name="Leyline Gloves", augments={'Accuracy+7','"Mag.Atk.Bns."+10',}},
    legs="Aya. Cosciales +1",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
    back=Sucellos.DW}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    
    head="Viti. Chapeau +3",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Vitiation Boots +3",
    neck="Light Gorget",
    waist="Light Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Rufescent Ring",
    right_ring="Karieyh Ring",
	back=Sucellos.WSD
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, 
        {     ammo="Yetshila",
    head={ name="Imp. Wing Hair. +1", augments={'Path: A',}},
    body={ name="Taeon Tabard", augments={'Accuracy+19 Attack+19','Crit.hit rate+3','Crit. hit damage +2%',}},
    hands="Jhakri Cuffs +2",
    legs="Viti. Tights +2",
    feet="Thereoid Greaves",
    neck="Light Gorget",
    waist="Light Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Begrudging Ring",
    right_ring="Apate Ring",
    back=Sucellos.Crit})
	
	    sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS, 
        {    
   
		left_ear="Malignance Earring",
	   
		})
		sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, 
        {    
			ammo="Crepuscular Pebble",
		    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Malignance Tabard",
			hands="Jhakri Cuffs +2",
			legs="Malignance Tights",
			feet="Malignance Boots",
			neck="Thunder Gorget",
			waist="Prosilio Belt",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Ishvara Earring",
			left_ring="Rufescent Ring",
			right_ring="Karieyh Ring",
			back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},})
		
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, 
        {   
			--range="Kaja Bow",
			--ammo="Chapuli Arrow",
			--ammo="Crepuscular Pebble",
		    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
			body="Malignance Tabard",
			hands="Jhakri Cuffs +2",
			legs="Malignance Tights",
			feet="Malignance Boots",
			neck="Thunder Gorget",
			waist="Prosilio Belt",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Ishvara Earring",
			left_ring="Rufescent Ring",
			right_ring="Karieyh Ring",
			back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},})
			
		sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS, 
        {   
			range="Kaja Bow",
			head="Nyame Helm",
			body="Nyame Mail",
			hands="Nyame Gauntlets",
			legs="Nyame Flanchard",
			feet="Nyame Sollerets",
			neck="Marked Gorget",
			waist="Light Belt",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Clearview Earring",
			left_ring="Longshot Ring",
			right_ring="Karieyh Ring",
			back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},})
				
	
	   sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, 
        {     
			ammo="Yetshila",
			head={ name="Imp. Wing Hair. +1", augments={'Path: A',}},
			body={ name="Taeon Tabard", augments={'Accuracy+19 Attack+19','Crit.hit rate+3','Crit. hit damage +2%',}},
			hands="Jhakri Cuffs +2",
			legs="Viti. Tights +2",
			feet="Thereoid Greaves",
			neck="Light Gorget",
			waist="Light Belt",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Sherida Earring",
			left_ring="Begrudging Ring",
			right_ring="Apate Ring",
			back=Sucellos.Crit})
		
		   sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS, 
           { 
	
			head="Jhakri Coronal +2",
			body="Jhakri Robe +2",
			hands="Jhakri Cuffs +2",
			legs="Nyame Flanchard",
			feet="Vitiation Boots +3",
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Malignance Earring",
			left_ring="Karieyh Ring",
			right_ring="Aquasoul Ring",
			back=Sucellos.MND})
	
			   sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS, 
           { 
			head="Jhakri Coronal +2",
			body="Jhakri Robe +2",
			hands="Jhakri Cuffs +2",
			legs="Jhakri Slops +2",
			feet="Vitiation Boots +3",
			neck="Sanctity Necklace",
			waist="Eschan Stone",
			left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
			right_ear="Malignance Earring",
			left_ring="Karieyh Ring",
			right_ring="Aquasoul Ring",
			back=Sucellos.MND})

				   sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, 
           { head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Vitiation Boots +3",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Malignance Earring",
    left_ring="Karieyh Ring",
    right_ring="Aquasoul Ring",
    back=Sucellos.MND})

    sets.precast.WS['Sanguine Blade'] = {
	ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Nyame Flanchard",
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck="Sanctity Necklace",
    waist="Anrin Obi",
    left_ear="Friomisi Earring",
    right_ear="Malignance Earring",
    left_ring="Archon Ring",
    right_ring="Karieyh Ring",
    back=Sucellos.MND
		}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +1",ear2="Loquacious Earring",
        body="Vitivation Tabard",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Cure = {    
	main="Daybreak",  
	ammo="Staunch Tathlum",
    head="Chironic Hat",
    body="Viti. Tabard +3",
    hands="Serpentes Cuffs",
    legs="Atrophy Tights +2",
    feet="Serpentes Sabots",
    neck="Henic Torque",
    waist="Gishdubar Sash",
    left_ear="Malignance Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Solemnity Cape"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

   

    sets.midcast.Refresh = {legs="Estoqueur's Fuseau +2"}

    sets.midcast.Stoneskin = {waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {
	main="Crocea Mors", 
    sub="Daybreak",
    ammo="Regal Gem",
    head="Viti. Chapeau +3",
    body="Lethargy Sayon",
    hands="Leth. Gantherots +1",
    legs="Chironic Hose",
    feet="Vitiation Boots +3",
    neck="Dls. Torque +2",
    waist="Obstin. Sash",
    left_ear="Vor Earring",
    right_ear="Snotra Earring",
    left_ring="Kishar Ring",
    right_ring="Stikini Ring",
    back=Sucellos.MND}
	
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'], {    
	main="Crocea Mors", 
    sub="Daybreak",
	ammo="Regal Gem",
    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Atrophy Tabard +3",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Snotra Earring",
    right_ear="Vor Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring"})
	
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
    
    sets.midcast['Elemental Magic'] = {    ammo="Dosis Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Vitiation Boots +3",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Malignance Earring",
    left_ring="Locus Ring",
    right_ring="Jhakri Ring",
    back=Sucellos.Nuke
	}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {    
	ammo="Regal Gem",
    head="Aya. Zucchetto +2",
    body="Atrophy Tabard +3",
    hands="Jhakri Cuffs +2",
    legs="Aya. Cosciales +1",
    feet="Vitiation Boots +3",
    neck="Deceiver's Torque",
    waist="Eschan Stone",
    left_ear="Malignance Earring",
    right_ear="Snotra Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back=Sucellos.MND}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


	 sets.midcast['Enhancing Magic'] = {
	main="Pukulatmuj +1",
    sub="Forfend +1",
	ammo="Hydrocera",
    head="Carmine Mask +1",
    body="Viti. Tabard +3",
	hands="Viti. Gloves +2",
    legs="Atrophy Tights +2",
    feet="Leth. Houseaux +1",
    neck="Melic Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Augment. Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Ghostfyre Cape"}

    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], { hands="Atrophy Gloves +2",neck="Dls. Torque +2"})
	
	sets.midcast['Haste II'] = set_combine(sets.midcast['Enhancing Magic'], {neck="Dls. Torque +2", hands="Atrophy Gloves +2", back=Sucellos.MND})
	sets.midcast['Refresh III'] = set_combine(sets.midcast['Enhancing Magic'], {body="Atrophy Tabard +3", neck="Dls. Torque +2", hands="Atrophy Gloves +2", back=Sucellos.MND})
    sets.buff.ComposureOther = {head="Estoqueur's Chappel +2",
        body="Estoqueur's Sayon +2",hands="Estoqueur's Gantherots +2",
        legs="Estoqueur's Fuseau +2",feet="Estoqueur's Houseaux +2"}

    sets.buff.Saboteur = {hands="Estoqueur's Gantherots +2"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitivation Chapeau",neck="Wiglen Gorget",
        body="Atrophy Tabard +3",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

	sets.precast.RA = {
	range="Trollbane"
	
    }

    -- Idle sets
    sets.idle = {   
    head="Viti. Chapeau +3",
    body="Atrophy Tabard +3",
    hands="Malignance Gloves",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Merman's Earring",
    right_ear="Loquac. Earring",
    left_ring="Warden's Ring",
    right_ring="Griffon Ring",
    back=Sucellos.DW
	}

    sets.idle.Town = { 

	ammo="Staunch Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Odnowa Earring +1",
    right_ear="Infused Earring",
    left_ring="Warden's Ring",
    right_ring="Griffon Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Damage taken-5%',}},
	}
    
    sets.idle.Weak = {   
    head="Malignance Chapeau",
    body="Atrophy Tabard +3",
    hands="Aya. Manopolas +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Merman's Earring",
    right_ear="Loquac. Earring",
    left_ring="Aquasoul Ring",
    right_ring="Griffon Ring",
    back=Sucellos.DW}

    sets.idle.PDT = {    ammo="Staunch Tathlum",
    head="Malignance Chapeau",
    body="Atrophy Tabard +3",
    hands="Aya. Manopolas +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Merman's Earring",
    right_ear="Loquac. Earring",
    left_ring="Aquasoul Ring",
    right_ring="Griffon Ring",
    back=Sucellos.DW}

    sets.idle.MDT = {    ammo="Staunch Tathlum",
    head="Malignance Chapeau",
    body="Atrophy Tabard +3",
    hands="Aya. Manopolas +2",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Merman's Earring",
    right_ear="Loquac. Earring",
    left_ring="Aquasoul Ring",
    right_ring="Griffon Ring",
    back=Sucellos.DW}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +3",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	--main="Naegling", 
    --sub="Machaera +2",
    	
    -- Normal melee group
    sets.engaged = {
	--main="Excalibur",
	--sub="Forfend",
	main="Crocea Mors", 
	--sub="Gleti's Knife",
    --main="Gleti's Knife",	
	sub="Daybreak",  
	--sub="Genmei Shield", 
	--main="Naegling", 
    --sub="Machaera +2",
    ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
	back=Sucellos.DW
	}
	sets.engaged.Enspell = {
    --main="Qutrub Knife",
    --sub="Ceremonial Dagger",
	main="Crocea Mors",
	sub="Gleti's Knife",	
    ammo="Regal Gem",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs={ name="Viti. Tights +2", augments={'Enspell Damage','Accuracy',}},
    feet="Malignance Boots",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Snotra Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Chirich Ring", 
	back=Sucellos.DW
	}
	
		sets.engaged.Savage = {
	main="Naegling",
	--sub="Genmei Shield", 	
    sub="Machaera +2",
    ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
	back=Sucellos.DW
	}
	
	sets.engaged.blunt = {
    main="Maxentius",	
	 sub="Machaera +2",
    ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
	back=Sucellos.DW
	}
	
	sets.engaged.Piercing = {
    main="Tauret",	
	sub="Gleti's Knife",	
    ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
	back=Sucellos.DW
	}
	
	sets.engaged.Tank = {
		main="Crocea Mors", 
	--sub="Gleti's Knife",
    --main="Gleti's Knife",	
	sub="Daybreak", 
    ammo="Staunch Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Merman's Earring",
    right_ear="Tuisto Earring",
    left_ring="Warden's Ring",
    right_ring="Chirich Ring",
    back="Moonbeam Cape",
	}
	
	sets.engaged.Arrow = {

	--main="Crocea Mors", 
	
	--sub="Daybreak",  
	--sub="Genmei Shield", 
	main="Naegling", 
    sub="Machaera +2",
    range="Kaja Bow",
	ammo="Chapuli Arrow",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
	back=Sucellos.DW
	}
	
	
	

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +3",hands="Atrophy Gloves +2",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Atrophy Boots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 13)
    else
        set_macro_page(1, 13)
    end
end
