
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
	-- Whether to use Luzaf's Ring
	state.LuzafRing = M(false, "Luzaf's Ring")
	state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')

	define_roll_values()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Melee', 'Acc')
	state.HybridMode:options('Normal', 'PDT' )
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Chrono Bullet"
	gear.QDbullet = "Chrono Bullet"
	--gear.QDbullet = "Adlivun Bullet"
	options.ammo_warning_limit = 15

    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }

    cor_sub_weapons = S{"Arendsi Fleuret", "Vanir Knife", "Sabebus", "Aphotic Kukri", "Atoyac", "Surcouf's Jambiya"}
    auto_gun_ws = "Wildfire"

    get_combat_form()
	-- Additional local binds
	-- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
	send_command('bind ^` input /ja "Double-up" <me>')
	send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command('bind != gs c toggle CapacityMode')
    
    send_command('bind ^- gs c cycle AutoRA')
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	send_command('unbind ^`')
	send_command('unbind !=')
	send_command('unbind !`')
	send_command('unbind ^-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	
	 Camulus = {}
	  Camulus.SS = {name="Camulus's Mantle", augments={'"Snapshot"+10',}}
     Camulus.RA = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
     Camulus.WSD = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+2','Weapon skill damage +10%'}}
	 Camulus.MAB = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	 Camulus.SAVAGE = {name="Camulus's Mantle", augments={'Accuracy+20 Attack+20','"STR+29','Weapon skill damage +10%'}}
	 Camulus.DA = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	  
	 
	
	 HerculeanHead = {}
     HerculeanHead.WSD = { name="Herculean Helm", augments={'Attack+22','Weapon skill damage +3%','Accuracy+5',}}
	 HerculeanHead.MAB = {name="Herculean Helm", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Crit. hit damage +2%','"Mag.Atk.Bns."+14',}}
	 
	 
	 HerculeanLegs = {}
	 HerculeanLegs.RWSD = {name="Herculean Trousers",  augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +4%','STR+7','Rng.Acc.+6',}}
     HerculeanLegs.WSD = {name="Herculean Trousers", augments={'Weapon skill damage +3%','STR+10','Attack+11',}}
	 HerculeanLegs.MAB = {name="Herculean Trousers", augments={'Weapon skill damage +3%','Accuracy+15','Magic Damage +17','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	 
	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
	--sets.precast.JA['Snake Eye'] = {legs="Commodore Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	--sets.precast.JA['Fold'] = {hands="Commodore Gants +2"}} 
    sets.CapacityMantle = {back="Mecistopins Mantle"}
	
	sets.precast.CorsairRoll = {
        head="Comm. Tricorne",
        hands="Chasseur's Gants +1",
        body="Lanun Frac +3",
        ring1="Barataria Ring",
        back="Gunslinger's Cape",
        feet="Lanun Bottes"
    }
    TaeonHands = {}
    TaeonHands.Snap = {name="Taeon Gloves", augments={'Attack+22','"Snapshot"+8'}}
	
	--sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
	--sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
	
	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    --sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
	
	sets.precast.CorsairShot = {}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
        hands="Iuitl Wristbands +1",
        legs="Adhemar Kecks",
    }

    sets.Organizer = {
        main="Arendsi Fleuret",
        sub="Odium",
        range="Doomsday",
        hands="Compensator",
        ammo="Legion Scutum"
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
        --ammo="Impatiens",
        head="Ejekamal Mask",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Comm. Charm +1"})

	sets.precast.RA = {
    ammo="Chrono Bullet",
    head="Malignance Chapeau",
    body="Oshosi Vest",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Malignance Boots",
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
    back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}},
    }

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
       ammo=gear.RAbullet,
		head="Ikenga's Hat",
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +4%','STR+7','Rng.Acc.+6',}},
		feet="Ikenga's Clogs",
		neck="Light Gorget",
		waist="Light Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
    }


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Samnuha Tights"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring", legs="Samnuha Tights"})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
      ammo=gear.RAbullet,
		head="Ikenga's Hat",
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +4%','STR+7','Rng.Acc.+6',}},
		feet="Ikenga's Clogs",
		neck="Scout's Gorget +1",
		waist="Light Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+30','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
    })

	sets.precast.WS['Savage Blade'] = {
        ammo=gear.RAbullet,
        head=HerculeanHead.WSD,   
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        ring2="Karieyh Ring",
        ring2="Apate Ring",
        back=Camulus.SAVAGE,
		neck="Thunder Gorget",
        waist="Thunder Belt",
        legs="Meg. Chausses +2",
        feet="Lanun Bottes +3"
    }
	
		sets.precast.WS['Decimation'] = {
        ammo=gear.RAbullet,
		head={ name="Herculean Helm", augments={'Attack+22','Weapon skill damage +3%','Accuracy+5',}},
		body={ name="Herculean Vest", augments={'Accuracy+27','Pet: Accuracy+10 Pet: Rng. Acc.+10','Quadruple Attack +2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','AGI+6',}},
		neck="Light Gorget",
		waist="Light Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Karieyh Ring",
		right_ring="Beithir Ring",
		back={ name="Belenus's Cape", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
	sets.precast.WS['Evisceration'] = {
		head="Mummu Bonnet +2",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +1",
		neck="Light Gorget",
		waist="Light Belt",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring",
		right_ring="Begrudging Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-3%',}},
    }
	
	
	sets.precast.WS['Circle Blade'] = {
        ammo=gear.RAbullet,
        head=HerculeanHead.WSD,   
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        ring2="Karieyh Ring",
        ring2="Apate Ring",
        back=Camulus.SAVAGE,
		neck="Comm. Charm +1",
        waist="Thunder Belt",
         legs="Meg. Chausses +2",
        feet="Lanun Bottes +3"
    }
	
		sets.precast.WS['Trueflight'] = {
        ammo=gear.RAbullet,
		ammo="Chrono Bullet",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Weapon skill damage +3%','Accuracy+15','Magic Damage +17','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Crit.hit rate+2','MND+1','"Mag.Atk.Bns."+14',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Karieyh Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+30','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
		sets.precast.WS['Wildfire'] = {
        ammo=gear.RAbullet,
		ammo="Chrono Bullet",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Weapon skill damage +3%','Accuracy+15','Magic Damage +17','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Crit.hit rate+2','MND+1','"Mag.Atk.Bns."+14',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		left_ring="Karieyh Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+30','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	sets.precast.WS['Hot Shot'] = {
        ammo=gear.RAbullet,
		ammo="Chrono Bullet",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Weapon skill damage +3%','Accuracy+15','Magic Damage +17','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Crit.hit rate+2','MND+1','"Mag.Atk.Bns."+14',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Karieyh Ring",
		right_ring="Apate Ring",
		back={ name="Belenus's Cape", augments={'AGI+30','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	

	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], { head="Pixie Hairpin +1", ear2="Friomisi Earring", ear1="Moonshade Earring",  ring1="Archon Ring", waist ="Anrin Obi" })
	
	--sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], { head="Meghanada Visor +2", ring1="Apate Ring", ear2="Friomisi Earring", ear1="Moonshade Earring", waist="Light Belt",body="Laksa. Frac +3"})
	
	sets.precast.WS['Numbing Shot'] = set_combine(sets.precast.WS['Last Stand'], {ear2="Clearview Earring", waist="Thunder Belt",Neck="Thunder Gorget"})
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Uk'uxkaj Cap",
        neck="Comm. Charm +1",
        hands="Iuitl Wristbands +1",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        body="Pursuer's Doublet",
        back="Gunslinger's Cape",
        ring1="Globidonta Ring",
        ring2="Sangoma Ring",
		legs="Adhemar Kecks",
        waist="Aquiline Belt",
    }
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {
        ammo="Hauksbok Bullet",
        head=HerculeanHead.MAB,
        neck="Comm. Charm +1",
        ear1="Hecate's Earring",
        ear2="Friomisi Earring",
        body="Lanun Frac +3",
        hands="Carmine Fin. Ga. +1",
        ring1="Acumen Ring",
        ring2="Karieyh Ring",
        back=Camulus.MAB,
        waist="Eschan Stone",
        legs=HerculeanLegs.MAB,
		feet="Chasseur's Bottes"
    }


		sets.precast.JA['Bounty Shot'] = {
		ammo=gear.RAbullet,
		head="Ikenga's Hat",
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Ikenga's Gloves",
		 legs={ name="Herculean Trousers", augments={'STR+2','Weapon skill damage +2%','"Treasure Hunter"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		feet="Ikenga's Clogs",
		neck="Marked Gorget",
		waist="Yemaya Belt",
		left_ear="Clearview Earring",
		right_ear="Volley Earring",
		left_ring="Longshot Ring",
		right_ring="Arewe Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
    }
	sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        body="Lanun Frac +3",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
        ring1="Perception Ring",
        ring2="Sangoma Ring",
	    feet="Chasseur's Bottes"
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

	-- Ranged gear
	sets.precast.RA = {
	ammo=gear.RAbullet,
    head="Ikenga's Hat",
    body={ name="Ikenga's Vest", augments={'Path: A',}},
    hands="Ikenga's Gloves",
    legs="Ikenga's Trousers",
    feet="Ikenga's Clogs",
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Longshot Ring",
    right_ring="Arewe Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
       
    }
	sets.midcast.RA = {
	ammo=gear.RAbullet,
    head="Ikenga's Hat",
    body={ name="Ikenga's Vest", augments={'Path: A',}},
    hands="Ikenga's Gloves",
    legs="Ikenga's Trousers",
    feet="Ikenga's Clogs",
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Clearview Earring",
    right_ear="Volley Earring",
    left_ring="Longshot Ring",
    right_ring="Arewe Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    })
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
       
            head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Eschan Stone",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Karieyh Ring",
    right_ring="Chirich Ring",
    back="Moonbeam Cape",
    }
    sets.idle.Regen = set_combine(sets.idle, {
        head="Ocelomeh Headpiece +1",
        neck="Comm. Charm +1",
        body="Kheper jacket",
    })

	sets.idle.Town = {
        head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Eschan Stone",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Karieyh Ring",
    right_ring="Chirich Ring",
    back="Moonbeam Cape",
      
    }
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle, {
			head="Malignance Chapeau",
			body="Meg. Cuirie +2",
			hands="Malignance Gloves",
			legs="Malignance Tights",
			feet="Meg. Jam. +2",
			neck="Comm. Charm +1",
			waist="Sailfi Belt +1",
			ear1="Merman's Earring",
			ear2="Thureous Earring",
			left_ring="Rajas Ring",
			right_ring="Apate Ring",
			back="Moonbeam Cape"
    })

	sets.defense.MDT = sets.defense.PDT

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {
    --ammo="Chrono Bullet",
    head="Malignance Chapeau",
    body="Oshosi Vest",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs="Malignance Tights",
	--legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Meg. Jam. +2",
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
    back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}},

    }
	-- Normal melee group
	sets.engaged.Melee = {
     head="Malignance Chapeau",
    body={ name="Herculean Vest", augments={'Accuracy+27','Pet: Accuracy+10 Pet: Rng. Acc.+10','Quadruple Attack +2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','AGI+6',}},
    neck="Ainia Collar",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Archon Ring",
    right_ring="Chirich Ring",
    back={ name="Belenus's Cape", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+10',}},

    }

	sets.engaged.Acc = set_combine(sets.engaged.Melee, {
        	head="Malignance Chapeau",
			body="Lanun Frac +3",
			hands="Malignance Gloves",
			legs="Malignance Tights",
			feet="Meg. Jam. +2",
			neck="Loricate Torque +1",
			waist="Sailfi Belt +1",
			ear1="Merman's Earring",
			ear2="Thureous Earring",
			left_ring="Rajas Ring",
			right_ring="Apate Ring",
			back="Moonbeam Cape"
    })
	sets.engaged.Acc.DW = set_combine(sets.engaged.Melee.DW, {
          --ring2="Mars's Ring"
    })
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end

	-- gear sets
	if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
		equip(sets.precast.LuzafRing)
	elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
		classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairRoll' and not spell.interrupted then
		display_roll_info(spell)
	end
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, default_wsmode)
	--if buffactive['Transcendancy'] then
	--	return 'Brew'
	--end
end
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
end

-- Job-specific toggles.
function job_toggle_state(field)
	if field:lower() == 'luzaf' then
		state.LuzafRing:toggle()
		return "Use of Luzaf Ring", state.LuzafRing.value
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = msg .. '[Auto RA: OFF]'
    end
    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if cor_sub_weapons:contains(player.equipment.main) then
    --if player.equipment.main == gear.Stave then
        if S{'NIN', 'DNC'}:contains(player.sub_job) and cor_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:set('Stave')
    end
end

function define_roll_values()
	rolls = {
		["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
		["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
		["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
		["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
		["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
		["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
		["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
		["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
		["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
		["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
		["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
		["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
		["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
		["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
		["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
		["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
		["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
		["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
		["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
		["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
		["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
		["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
		["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
		["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
		["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
		["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
		["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
		["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
		["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
	}
end

function display_roll_info(spell)
	rollinfo = rolls[spell.english]
	local rollsize = 'Small'
	if state.LuzafRing then
		rollsize = 'Large'
	end
	if rollinfo then
		add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
		add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
	end
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.element == 'None' then
				-- physical weaponskills
				bullet_name = gear.WSbullet
			else
				-- magical weaponskills
				bullet_name = gear.MAbullet
			end
		else
			-- Ignore non-ranged weaponskills
			return
		end
	elseif spell.type == 'CorsairShot' then
		bullet_name = gear.QDbullet
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Triple Shot'] then
			bullet_min_count = 3
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
			add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
			return
		elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
	if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
		add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
		eventArgs.cancel = true
		return
	end
	
	-- Low ammo warning.
	if spell.type ~= 'CorsairShot' and not state.warned
	    and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '**** LOW AMMO WARNING: '..bullet_name..' ****'
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
		state.warned = true
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned = false
	end
end

function use_weaponskill()
    send_command('input /ws "'..auto_gun_ws..'" <t>')
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '0.7' -- MAKE ADJUSTMENT HERE
        elseif buffactive['Flurry II'] then
            delay = '0.5'
        else
            delay = '1.05' -- MAKE ADJUSTMENT HERE
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function select_default_macro_book()
	set_macro_page(1, 14)
end