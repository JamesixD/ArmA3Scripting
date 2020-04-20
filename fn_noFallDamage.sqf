/*
  No fall damage script
  By: James_
  Discord: James_#8282
*/

/*
player addMPEventHandler ["HandleDamage", {

    private ["_player", "_damage", "source"];
    _player = _this select 0;
    _damage = _this select 2;
    _source = _this select 4;
    if ((_source == "") && !(isTouchingGround _player)) then {0} else {_damage};
}];
*/

//below is godmode whilst in air
player addMPEventHandler ["HandleDamage", {
  if !(isTouchingGround vehicle player) then {
    for "_i" from 0 to 1 step 0 do {
      player allowDamage false;
    };
    else (isTouchingGround) player allowDamage true;
  };
};
];
