-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
     
    state.CapacityMode = M(false, 'Capacity Point Mantle')
     
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Drakesbane'}
 
    state.Buff = {}
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
     
    war_sj = player.sub_job == 'WAR' or false
 
    select_default_macro_book(1, 16)
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end
 
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^=')
    send_command('unbind !=')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
    -- Start defining the sets
    --------------------------------------
     ValorMask = {}
     ValorMask.Crit = {name="Valorous Mask", augments={'"STR+12"'}}
	 ValorMask.WSD = {name="Valorous Mask", augments={'Weapon skill damage +2%'}}
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { head="Gavialis Helm" }
 
    sets.precast.JA.Jump = {
          
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
     hands="Vis. Fng. Gaunt. +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Dedition Earring",
    right_ear="Sherida Earring",
    left_ring="Rajas Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}}

 
    sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais" }
 
    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
    }) 
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {

    })
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
		hands="Sulev. Gauntlets +2",
        feet="Pelt. Schynbalds"})
    sets.precast.JA['Super Jump'] = sets.precast.JA.Jump
 
    sets.precast.JA['Spirit Link'] = {hands="Lancer's Vambraces +2", head="Vishap Armet +1"}
    sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail"}
    sets.precast.JA['Deep Breathing'] = {head="Petroslaver Armet"}
     
    sets.precast.JA['Spirit Surge'] = { body="Pteroslaver Mail"
    }
     
    -- Healing Breath sets
    sets.HB = {
        head="Pteroslaver Armet",neck="Lancer's Torque",ear1="Lancer's Earring",ear2="Bladeborn Earring",
        body="Cizin Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Updraft Mantle",waist="Glassblower's Belt",legs="Vishap Brais",feet="Wyrm Greaves +2"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Yaoyotl Helm",
        body="Mikinaak Breastplate",hands="Cizin Mufflers +1",ring1="Rajas Ring",
        back="Bleating Mantle",legs="Xaddi Cuisses",feet="Whirlpool Greaves"}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
    sets.precast.FC = {
      
        head="Cizin Helm +1", 
        ear1="Loquacious Earring", 
        hands="Buremte Gloves",
        ring1="Prolix Ring"
    }
     
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Wyrm Armet",
        neck="Adad Amulet",
        hands="Despair Fin. Gaunt.",
        body="Xaddi Mail",
        ring1="Beeline Ring",
        ring2="K'ayres Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        legs="Cizin Breeches +1",
        feet="Ejekamal Boots",
    }   
         
    sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { })
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
 
    sets.precast.WS = {
	 ammo="Focal Orb",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    hands="Sulev. Gauntlets +2",
    legs="Gleti's Breeches",
    feet="Sulev. Leggings +2",
    neck="Light Gorget",
    waist="Light Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Vulcan's Ring",
    right_ring="Karieyh Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
     
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        back="Updraft Mantle",
        head="Yaoyotl Helm",
        legs="Xaddi Cuisses"
    })
     
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
         neck="Light Gorget",
         waist="Light Belt"

    })
    sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
         neck="Light Gorget",
         waist="Light Belt"
    })
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Light Gorget",waist="Light Belt"})
	
	sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
	
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +1",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Ioskeha Belt",
		left_ear="Gwati Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	})
		sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {
	
		
		head={ name="Valorous Mask", augments={'Attack+15','Weapon skill damage +2%','Accuracy+6',}},
		body="Sulevia's Plate. +2",
		hands={ name="Valorous Mitts", augments={'Attack+11','Weapon skill damage +4%','STR+4','Accuracy+9',}},
		legs={ name="Valor. Hose", augments={'Attack+30','Weapon skill damage +3%','STR+8',}},
		feet="Sulev. Leggings +2",
		neck="Light Gorget",
		waist="Light Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",	
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	})

 
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
         
	
    ammo="Focal Orb",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    hands="Sulev. Gauntlets +2",
    legs="Gleti's Breeches",
    feet="Sulev. Leggings +2",
    neck="Light Gorget",
    waist="Light Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Vulcan's Ring",
    right_ring="Karieyh Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
    	
		head={ name="Valorous Mask", augments={'Attack+15','Weapon skill damage +2%','Accuracy+6',}},
		body="Sulevia's Plate. +2",
		hands={ name="Valorous Mitts", augments={'Attack+11','Weapon skill damage +4%','STR+4','Accuracy+9',}},
		legs={ name="Valor. Hose", augments={'Attack+30','Weapon skill damage +3%','STR+8',}},
		feet="Sulev. Leggings +2",
		neck="Light Gorget",
		waist="Light Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
	   back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
    })
    sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})
 
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		         neck="Light Gorget",
         waist="Light Belt"
    })
    sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
             neck="Light Gorget",
        waist="Light Belt"
    })
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {hands="Mikinaak Gauntlets"})
 
     
    -- Sets to return to when not performing an action.
     
    -- Resting sets
    sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Twilight Mail",
        hands="Cizin Mufflers +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
        back="Repulse Mantle",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
     
 
    -- Idle sets
    sets.idle = {}
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {
    
    head={ name="Valorous Mask", augments={'Attack+15','Weapon skill damage +2%','Accuracy+6',}},
    body={ name="Found. Breastplate", augments={'Accuracy+3','Mag. Acc.+6',}},
    hands="Sulev. Gauntlets +2",
    legs="Carmine Cuisses +1",
    feet="Sulev. Leggings +2",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Brutal Earring",
    right_ear="Merman's Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"}
     
    sets.idle.Field = set_combine(sets.idle.Town, { 
           
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Carmine Cuisses +1",
    feet="Sulev. Leggings +2",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Brutal Earring",
    right_ear="Merman's Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"})
 
    sets.idle.Regen = set_combine(sets.idle.Field, {
})
 
    sets.idle.Weak = set_combine(sets.idle.Field, {
    })
     
    -- Defense sets
    sets.defense.PDT = {
      
        head="Ighwa Cap",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        back="Repulse Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    }
 
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
        head="Twilight Helm",
        body="Twilight Mail"
    })
 
    sets.defense.MDT = sets.defense.PDT
 
    sets.Kiting = {legs="Crimson Cuisses"}
 
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {

    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Moonbeam Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}}
 
    sets.engaged.Mid = set_combine(sets.engaged, {

    })
 
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {

    })
 
    sets.engaged.PDT = set_combine(sets.engaged, {
   
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Brutal Earring",
    right_ear="Mache Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })
 
    sets.engaged.War = set_combine(sets.engaged, {
        --head="Yaoyotl Helm",
        feet="Mikinaak Greaves",
        ring2="K'ayres Ring"
    })
    sets.engaged.War.Mid = sets.engaged.Mid
 
    sets.engaged.Reraise = set_combine(sets.engaged, {
    })
 
    sets.engaged.Acc.Reraise = sets.engaged.Reraise
     
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if player.hpp < 51 then
        classes.CustomClass = "Breath" 
    end
     
end
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
        if player.hpp < 51 then
            classes.CustomClass = "Breath" 
        end
    end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end
 
function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
        equip(sets.HB)
    end
end
 
-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
     
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
 
end
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)
 
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
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
 
-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
 
function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
    classes.CustomMeleeGroups:clear()
    th_update(cmdParams, eventArgs)
    get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
 
end
 
function get_combat_form()
    --if areas.Adoulin:contains(world.area) and buffactive.ionis then
    --  state.CombatForm:set('Adoulin')
    --end
 
    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end
 
 
-- Job-specific toggles.
function job_toggle(field)
 
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end