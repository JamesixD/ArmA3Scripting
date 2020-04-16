//By James_ - Discord: James_#8282 for JustUnknown Altis Life

//close inventory
closeDialog 0;

//error checks
if (life_action_inUse) exitWith {};
if (isNull || !alive player) exitWith {};
if ((player getVariable "restrained")) exitWith {titleRsc ["How you want to do that whilst restrained?",PLAIN,5,true]};
if ((player getVariable "tied")) exitWith {titleRsc ["How you want to do that whilst ziptied?",PLAIN,5,true]};
if ((player getVariable "tazed")) exitWith {titleRsc ["How you want to do that whilst tazed?",PLAIN,5,true]};
uiSleep 0.1;

//warning
titleText ["Starting to feel high...", "RED", 5];
sleep 3;

//effect activation
"chromAberration" ppEffectEnable true;
"radialBlur" ppEffectEnable true;
enableCamShake true;
_smoke = "SmokeShellGreen" createVehicle position player;
if (vehicle player != player) then {
        _smoke attachTo [vehicle player, [-1,-1,1]];
    };
    else  {
        _smoke attachTo [player, [1,-1,1]];
    };

//effects for 1 min
for "_i" from 0 to 59 do {
    "chromAberration" ppEffectAdjust [random 0.25,random 0.25,true];
    "chromAberration" ppEffectCommit 1;
    "radialBlur" ppEffectAdjust  [random 0.02,random 0.02,0.15,0.15];
    "radialBlur" ppEffectCommit 1;
    addcamShake[random 3, 1, random 3];
    sleep 1;
};

//cease/stop effects
"chromAberration" ppEffectAdjust [0,0,true];
"chromAberration" ppEffectCommit 5;
"radialBlur" ppEffectAdjust  [0,0,0,0];
"radialBlur" ppEffectCommit 5;
sleep 5;

//Deactivate ppEffects
"chromAberration" ppEffectEnable false;
"radialBlur" ppEffectEnable false;
resetCamShake;

titleText ["Damn, that was a fat blunt!", "GREEN", 5];
