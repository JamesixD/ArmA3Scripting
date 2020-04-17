/*
  ChopShop reward script, depending on vehicle damage (specific to vehicle parts)
  and model the chopping reward decreases.
  By: James_ -> Discord: James_#8282
  Script Info:
  _vehModels = veh classnames:
  switch statement for each veh
*/

//Below for server: function name, e.g. Server_ChopShop_Reward -> dependant on framework
["fnc_ChopReward", {
  private [ "_player", "_veh", "_vehpart", "_vehDamage", "_vehModels" "_fullReward", "_currentDamage" ];
  _veh = [ 0, objNull ];
  if ( isNull _veh ) exitWith {};
  _player = [ 1, objNull ];
  _vehpart = [ "Engine", "Hull", "Fuel", "Transmission", "Wheel1", "Wheel2", "Wheel3", "Wheel4", "Glass1", "Glass2", "Glass3", "Glass4", "Glass5" ];
  _vehDamage = { _veh getHit _x } forEach _vehpart;
  _vehpartDamage = { _veh getHitPointDamage _x } forEach _vehpart;
  _vehModels = [ "B_MRAP_01_F", "B_G_Offroad_01_F", "B_T_Truck_01_box_F" ]; //later on rework for array in array -> vehicle groups
                                                                            //str veh classnames into veh names like Hunter etc.
  switch (_vehModels) do {
    case "veh1": {
      ((_vehModels) select 0);
      _fullReward = 20000;
    };
    case "veh2": {
      ((_vehModels) select 1);
      _fullReward = 10000;
    };
    case "veh3": {
      ((_vehModels) select 2);
      _fullReward = 12000;
    };
  };

  if (_vehdamage < 1) then {
    switch (_vehpart) do {
      case "Engine": {
        ((_vehpart) select 0) && if  [0, (_vehpartDamage < 0.9)] then {
          _fullReward - 1000;
        };
        else ((_vehpartdamage > 0.9)) exitWith {};
      };
      case "Wheels": {
        [((_vehpart), select 4, select 5, select 6, select 7)];
        if (_this (_vehpartdamage < 0.9)) then {
          {_fullReward - 350} forEach _x;
          };
        };
        case "HullFuelTransmission": {
          [((_vehpart), select 1, select 2, select 3)];
          if (_this (_vehpartdamage < 0.9)) then {
            {_fullReward - 500} forEach _x;
          };
        };
        case "Glass": {
          [((_vehpart), select 8, select 9, select 10, select 11, select 12)];
          if (_this (_vehpartdamage < 0.9)) then {
            {_fullReward - 400} forEach _x;
          };
        };
      };
    };
  };

  count _fullReward;

//variables "owner" & "player" are different for each framework
  if (((_veh getVariable "owner") select 0) != (getPlayerUID _player)) then
  {
      [_player,"Player_Cash",((_player getVariable ["player_cash",0]) + call (_fullReward)];
      //call Server_Core_ChangeVar;
  };


  //the below is for the altis life framework (5.0)
  if (life_HC_isActive) then {
      [_player,_veh,_fullReward] remoteExecCall ["HC_fnc_chopShopSell",HC_Life];
  } else {
      [_player,_veh,_fullReward] remoteExecCall ["TON_fnc_chopShopSell",RSERV];
  };

  //the below function is also named different for each framework below is for modded
  [_veh] call Server_Chopshop_Storecar;
  
  //final check if vehicle has been stored or not
  if _veh !(isNull) exitWith {deleteVehicle _veh};
};
];
