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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
    blue_magic_maps.StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{'Flash Nova', 'Sanguine Blade'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Hybrid','Blunt','HybridBlunt')
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
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Aya. Cosciales +2",
    feet="Jhakri Pigaches +2",
    neck="Mirage Stole +1",
    waist="Witful Belt",
    left_ear="Mendi. Earring",
    right_ear="Dominance Earring",
    left_ring="Jhakri Ring",
    right_ring="Stikini Ring",
    back="Swith Cape"}

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
    {    
	ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body="Gleti's Cuirass",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Gleti's Breeches",
    feet={ name="Herculean Boots", augments={'Attack+22','"Triple Atk."+3','STR+14','Accuracy+3',}},
    neck="Asperity Necklace",
    waist="Light Belt",
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Begrudging Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})

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
			
			
		
		
		   sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS, 
           { 
	
		    ammo="Hydrocera",
			head="Jhakri Coronal +2",
			body="Jhakri Robe +2",
			hands="Jhakri Cuffs +2",
			legs="Luhlaza Shalwar +3",
			feet="Jhakri Pigaches +2",
			neck="Stoicheion Medal",
			waist="Eschan Stone",
			left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
			right_ear="Friomisi Earring",
			left_ring="Fenrir Ring",
			right_ring="Fenrir Ring",
			back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
			
			})
	
			sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS, 
           { 
		    ammo="Hydrocera",
			head="Jhakri Coronal +2",
			body="Jhakri Robe +2",
			hands="Jhakri Cuffs +2",
			legs="Luhlaza Shalwar +3",
			feet="Jhakri Pigaches +2",
			neck="Stoicheion Medal",
			waist="Eschan Stone",
			left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
			right_ear="Friomisi Earring",
			left_ring="Fenrir Ring",
			right_ring="Fenrir Ring",
			back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
			
			})


			sets.precast.WS['Sanguine Blade'] = {
			ammo="Hydrocera",
			head="Pixie Hairpin +1",
			body="Jhakri Robe +2",
			hands="Jhakri Cuffs +2",
			legs="Luhlaza Shalwar +3",
			feet="Jhakri Pigaches +2",
			neck="Stoicheion Medal",
			waist="Eschan Stone",
			left_ear="Friomisi Earring",
			right_ear="Hecate's Earring",
			left_ring="Archon Ring",
			right_ring="Fenrir Ring",
			back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
				}

			
			sets.precast.WS['Savage Blade'] = {
			 ammo="Staunch Tathlum",
			head="Gleti's Mask",
			body="Assim. Jubbah +2",
			hands="Jhakri Cuffs +2",
			legs="Luhlaza Shalwar +3",
			feet="Gleti's Boots",
			neck="Mirage Stole +1",
			waist="Light Belt",
			left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
			right_ear="Odr Earring",
			left_ring="Apate Ring",
			right_ring="Rajas Ring",
			back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
			}
	
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
            ammo="Staunch Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Aya. Cosciales +2",
    feet="Jhakri Pigaches +2",
    neck="Mirage Stole +1",
    waist="Witful Belt",
    left_ear="Mendi. Earring",
    right_ear="Dominance Earring",
    left_ring="Jhakri Ring",
    right_ring="Stikini Ring",
    back="Swith Cape"}

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

   
	    sets.midcast['Blue Magic'] = {
    ammo="Mavi Tathlum",
    head="Mirage Keffiyeh",
    body="Assim. Jubbah +2",
    hands="Jhakri Cuffs +2",
    legs="Aya. Cosciales +2",
    feet="Jhakri Pigaches +2",
    neck="Mirage Stole +1",
    waist="Eschan Stone",
    left_ear="Mendi. Earring",
    right_ear="Dominance Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Felicitas Cape +1",
        }
		

    sets.midcast['Blue Magic'].Physical = {
     ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body={ name="Herculean Vest", augments={'"Triple Atk."+4','DEX+10','Accuracy+15','Attack+12',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'"Dual Wield"+3','"Blood Boon"+6','Quadruple Attack +2','Accuracy+1 Attack+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    feet={ name="Herculean Boots", augments={'Attack+22','"Triple Atk."+3','STR+14','Accuracy+3',}},
    neck="Asperity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        }

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
        ammo="Voluspa Tathlum",
        head="Carmine Mask +1",
        hands=gear.Adhemar_A_hands,
        legs="Carmine Cuisses +1",
        feet=gear.Herc_STP_feet,
        neck="Mirage Stole +2",
        ear2="Telos Earring",
        back="Cornflower Cape",
        waist="Grunfeld Rope",
        })

    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Mache Earring +1",
        ring2="Ilabrat Ring",
        back=gear.BLU_WS1_Cape,
        waist="Grunfeld Rope",
        })

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
        hands=gear.Adhemar_B_hands,
        ring2="Ilabrat Ring",
        })

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Regal Earring",
        ring1="Shiva Ring +1",
        ring2="Metamor. Ring +1",
        back=gear.BLU_MAB_Cape,
        waist="Acuity Belt +1",
        })

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        })

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring", ear2="Enchntr. Earring +1"})

    sets.midcast['Blue Magic'].Magical = {
	    ammo="Hydrocera",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet="Jhakri Pigaches +2",
    neck="Stoicheion Medal",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Fenrir Ring",
    right_ring="Fenrir Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
    ammo="Hydrocera",
    head="Jhakri Coronal +2",
    body="Assim. Jubbah +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Stoicheion Medal",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        })

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
        })

    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring2="Weather. Ring +1"
        })

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        })

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Aurgelmir Orb +1",
        ear2="Mache Earring +1",
        ring2="Ilabrat Ring",
        })

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Aurgelmir Orb +1",
        })

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Voluspa Tathlum",
        ear1="Regal Earring",
        ear2="Enchntr. Earring +1"
        })

    sets.midcast['Blue Magic'].MagicAccuracy = {
   ammo="Hydrocera",
    head="Jhakri Coronal +2",
    body="Assim. Jubbah +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Stoicheion Medal",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {head="Luh. Keffiyeh +3"})

    sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        ammo="Voluspa Tathlum",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Mirage Stole +2",
        ear2="Mache Earring +1",
        back=gear.BLU_TP_Cape,
        waist="Eschan Stone",
        })

    sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic'].Healing = {
        ammo="Staunch Tathlum +1",
        head="Carmine Mask +1",
        body="Vrikodara Jupon", -- 13
        hands=gear.Telchine_ENH_hands, -- 10
        legs="Assim. Shalwar +3",
        feet="Medium's Sabots", -- 12
        neck="Nuna Gorget +1",
        ear1="Mendi. Earring", -- 5
        ear2="Regal Earring",
        ring1="Lebeche Ring", -- 3
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Oretan. Cape +1", --6
        waist="Luminary Sash",
        }

    sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
        hands="Buremte Gloves", -- (13)
        legs="Gyve Trousers", -- 10
        neck="Phalaina Locket", -- 4(4)
        ring2="Asklepian Ring", -- (3)
        back="Solemnity Cape", --7
        waist="Gishdubar Sash", -- (10)
        })

    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
        head=gear.Adhemar_D_head,
        neck="Sanctity Necklace",
        ear2="Etiolation Earring",
        ring2="Eihwaz Ring",
        back="Moonlight Cape",
        waist="Kasiri Belt",
        })

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
    sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {head="Amalric Coif +1", waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
        hands="Hashi. Bazu. +1",
        ear1="Njordr Earring",
        ear2="Enchntr. Earring +1",
        ring2="Weather. Ring +1",
        waist="Witful Belt",
        }) -- 1 shadow per 50 skill

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        head="Amalric Coif +1",
        waist="Emphatikos Rope",
        })
    

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
    main="Kaja Sword",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','Accuracy+13','Attack+17','DMG:+15',}},
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body={ name="Herculean Vest", augments={'"Triple Atk."+4','DEX+10','Accuracy+15','Attack+12',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'"Dual Wield"+3','"Blood Boon"+6','Quadruple Attack +2','Accuracy+1 Attack+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    feet={ name="Herculean Boots", augments={'Attack+22','"Triple Atk."+3','STR+14','Accuracy+3',}},
    neck="Asperity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
	sets.engaged.Hybrid = {
       main="Kaja Sword",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','Accuracy+13','Attack+17','DMG:+15',}},
    ammo="Staunch Tathlum",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body="Nyame Mail",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Sailfi Belt +1",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
	
	sets.engaged.Blunt = {
    main="Nibiru Cudgel",
    sub="Nibiru Cudgel",
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body={ name="Herculean Vest", augments={'"Triple Atk."+4','DEX+10','Accuracy+15','Attack+12',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'"Dual Wield"+3','"Blood Boon"+6','Quadruple Attack +2','Accuracy+1 Attack+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    feet={ name="Herculean Boots", augments={'Attack+22','"Triple Atk."+3','STR+14','Accuracy+3',}},
    neck="Asperity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
	
	sets.engaged.HybridBlunt = {
    main="Nibiru Cudgel",
    sub="Nibiru Cudgel",
    ammo="Staunch Tathlum",
    head={ name="Adhemar Bonnet +1", augments={'STR+8','DEX+8','Attack+12',}},
    body="Nyame Mail",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Sailfi Belt +1",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
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
