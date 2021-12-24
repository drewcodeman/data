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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
	 Rudianos = {}
     Rudianos.WSD = {name="Rudianos's Mantle", augments={'Accuracy+20 Attack+20','"STR+20','Weapon skill damage +10%'}}
	 Rudianos.FastCast = {name="Rudianos's Mantle", augments={'Accuracy+20 Attack+20','"DEX+2','Fast Cast+10'}}
	 Rudianos.DA = {name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	 
	 OdysseanGloves = {}
     OdysseanGloves.WSD = {name="Odyssean Gauntlets", augments={'Weapon skill damage +4%'}}
	 OdysseanGloves.FastCast = {name="Odyssean Gauntlets", augments={'Attack+11', '"Mag. Atk. Bns."+22'}}
	 
	 ValorMask = {}
     ValorMask.Crit = {name="Valorous Mask", augments={'"STR+12"'}}
	 ValorMask.WSD = {name="Valorous Mask", augments={'Weapon skill damage +2%'}}
	 
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Cab. Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Reverence Coronet +1",
        body="Rev. Surcoat +2",hands="Reverence Gauntlets +1",ring1="Leviathan Ring",ring2="Aquasoul Ring",
        back="Weard Mantle",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Reverence Coronet +1",
        body="Gorney Haubert +1",hands="Reverence Gauntlets +1",
        back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Odyssean Greaves"}
        
    -- Don't need any special gear for Fing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Staunch Tathlum",
		head={ name="Carmine Mask +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+6','Enmity+3','INT+2','Mag. Acc.+14',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+7','"Mag.Atk.Bns."+10',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
		neck="Loricate Torque +1",
		waist="Creed Baudrier",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+2','Accuracy+20 Attack+20','"Fast Cast"+10',}},
		}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Light Gorget",
		ear1="Tati Earring",
		ear2="Moonshade Earring",
		ring1="Adoulin Ring",
		ring2="Rufescent Ring",
        back=Rudianos.WSD,
		waist="Light Belt",

		}
		
        sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
        hands=OdysseanGloves.FastCast,
		ring1="Acumen Ring",
		ring2="Adoulin Ring",
		legs="Odyssean Cuisses",
		feet="Odyssean Greaves"})
		
	    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        neck="Light Gorget",
		head=ValorMask.Crit,
        waist="Light Belt",
		hands="Flam. Manopolas +1",
		legs="Sulev. Cuisses +2",
		ring2="Begrudging Ring",
		feet="Valorous Greaves",
		back=Rudianos.DA
    })
	
	sets.precast.WS['Atonement'] = set_combine(sets.precast.WS, {
		ammo="Incantor Stone",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Macabre Gaunt. +1",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Moonbeam Necklace",
		waist="Creed Baudrier",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Supershear Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
	
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Thunder Gorget",
        waist="Thunder Belt",
		--body="Found. Breastplate"

    })
	
		sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {		
        hands="Sulev. Gauntlets +2",
		back=Rudianos.DA,
		feet="Flam. Gambieras +1"})
		
		sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {	
        hands=OdysseanGloves.WSD})
		
        sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
         hands=OdysseanGloves.FastCast,
		ring1="Acumen Ring",
		ring1="Fenrir Ring",
		legs="Sulev. Cuisses +2",
		feet="Odyssean Greaves"})
    --------------------------------------
    -- Midcast sets
    --------------------------------------

  
        
    sets.midcast.Enmity = {
	    ammo="Incantor Stone",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Macabre Gaunt. +1",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
		neck="Moonbeam Necklace",
		waist="Creed Baudrier",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Supershear Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+2','Accuracy+20 Attack+20','"Fast Cast"+10',}},
		} 
		
		    sets.midcast.Interr = {
	    ammo="Incantor Stone",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Macabre Gaunt. +1",
		legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+13',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
		neck="Moonbeam Necklace",
		waist="Creed Baudrier",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Supershear Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+2','Accuracy+20 Attack+20','"Fast Cast"+10',}},
		} 

    sets.midcast.Flash = sets.midcast.Interr
	
	sets.midcast.Jettatura = sets.midcast.Interr
	
	sets.midcast['Blank Gaze'] = sets.midcast.Enmity
    
    sets.midcast.Stun = sets.midcast.Enmity
    
	sets.precast.Cure = {    
	
	ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands="Macabre Gaunt. +1",
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+13',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Nourish. Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",
	}
	
    sets.midcast.Cure = {    
	
	ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands="Macabre Gaunt. +1",
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+13',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Nourish. Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",
	}
	
	sets.midcast.Banishga = {    
	
	ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands="Leyline Gloves",
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+13',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
    neck="Moonbeam Necklace",
    waist="Creed Baudrier",
    left_ear="Nourish. Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",
	}
	
		sets.midcast['Blue Magic'] = {
	    ammo="Incantor Stone",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Macabre Gaunt. +1",
		legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+13',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
		neck="Moonbeam Necklace",
		waist="Creed Baudrier",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Supershear Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+2','Accuracy+20 Attack+20','"Fast Cast"+10',}},
		} 

    sets.midcast['Enhancing Magic'] = 
	{
	    ammo="Staunch Tathlum",
    head={ name="Carmine Mask +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+6','Enmity+3','INT+2','Mag. Acc.+14',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+7','"Mag.Atk.Bns."+10',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+11','Enmity+6','AGI+9','Mag. Acc.+12',}},
    neck="Enhancing Torque",
    waist="Creed Baudrier",
    left_ear="Mimir Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+2','Accuracy+20 Attack+20','"Fast Cast"+10',}},
	}
	
	sets.midcast['Reprisal'] = {
	ammo="Staunch Tathlum",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands="Sulev. Gauntlets +2",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Loricate Torque +1",
    waist="Creed Baudrier",
    left_ear="Creed Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
		}
	
	sets.midcast['Enlight II'] = 
	{
		ammo="Staunch Tathlum",
		head={ name="Jumalik Helm", augments={'MND+5','"Mag.Atk.Bns."+10','Magic burst dmg.+6%',}},
		body="Rev. Surcoat +2",
		hands="Eschite Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Henic Torque",
		waist="Asklepian Belt",
		left_ear="Beatific Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast['Holy II'] = {head="Rev. Coronet +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Rev. Surcoat +1",hands=OdysseanGloves.FastCast,ring1="Acumen Ring",ring1="Adoulin Ring",
        back="Solemnity Cape",waist="Sailfi Belt +1",legs="Sulev. Cuisses +2",feet="Odyssean Greaves"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    ---------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {
    ammo="Staunch Tathlum",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    waist="Creed Baudrier",
    left_ear="Thureous Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",}

    sets.idle.Town = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Sulev. Gauntlets +2",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Creed Baudrier",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
		}
		
    sets.idle.Weak = 
	{    
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +2",
		hands="Sulev. Gauntlets +2",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Creed Baudrier",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    

    -- Basic defense sets.        
    sets.defense.PDT = {
    ammo="Staunch Tathlum",
    head="Sulevia's Mask +2",
    body="Rev. Surcoat +2",
    hands="Sulev. Gauntlets +2",
    legs="Souv. Diechlings +1",
    feet="Souveran Schuhs +1",
    neck="Loricate Torque +1",
    waist="Sailfi Belt +1",
    ear1="Thureous Earring",
    ear2="Creed Earring",
    ring1="Moonbeam Ring",
    ring2="Moonbeam Ring",
    back="Moonbeam Cape",
}
		
	sets.defense.MDT = {
	ammo="Staunch Tathlum",
	head="Sakpata's Helm",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	legs="Sakpata's Cuisses",
	feet="Sakpata's Leggings",
	neck="Moonbeam Necklace",
	waist="Carrier's Sash",
	left_ear="Tuisto Earring",
	right_ear="Odnowa Earring +1",
	left_ring="Moonbeam Ring",
	right_ring="Moonbeam Ring",
	back="Solemnity Cape",
}
		


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
	    ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Moonbeam Necklace",
		waist="Sailfi Belt +1",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Chance of successful block +5',}},
		}
		
	sets.engaged.Acc = {
		ammo="Focal Orb",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Ainia Collar",
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Brutal Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Chance of successful block +5',}},
		}


    sets.engaged.PDT = set_combine(sets.engaged, {body="Rev. Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Rev. Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
	
	    sets.engaged.MDT = {
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Moonbeam Necklace",
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Solemnity Cape",
		}
    sets.engaged.Acc.MDT = set_combine(sets.engaged.Acc, {ring1="Defending Ring"})
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(2, 2)
    end
end