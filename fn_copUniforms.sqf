#include "..\script_macros.hpp"
#include "..\config\Config_Licenses.hpp"

/*
  By: James_ - Discord: James_#8282
  Purpose: initCop clothing function. objecttexture check &
  clothing assignment for normal cops & swat.
*/

private ["_texture","_dfltCop","_dfltCopUni","_swatMember","_swatUni"];

_texture = getObjectTextures player;
_dfltCopUni = [0,"textures\cop_uniform.jpg"];
_dfltCop = [0,"call life_coplevel <= 6"];             //["license_cop_swat",false]; [(player) !(license_cop_swat))];
_swatMember = [0,"call life_coplevel >= 7"];         //["license_cop_swat",true];
_swatUni = [0,"textures\swatuniform.jpg"];

[] spawn {
  while (true) do {
    switch (player) do {
      case "dfltCopAssignUni": {
        //waitUntil (uniform player == "U_Rangemaster");
        if player == ((_dfltCop) && !(_swatMember) then {
          player forceAddUniform "U_Rangemaster";
          player setObjectTextureGlobal [0,"textures\cop_uniform.jpg"];
          waitUntil  {((_texture) == (_dfltCopUni))};
          sleep 3;
          else (player (((_texture) !(_dfltCopUni)) && !(_swatMember))) then {
            waitUntil  {((_texture) == (_dfltCopUni)) && [] spawn case "dfltCopAssignUni";};
            systemChat "first log of player not automatically receiving uniform (COP)";
            sleep 2;
            if (player (((_texture) !(_dfltCopUni)) && !(_swatMember))) then {
              systemChat "player has not received uniform after 15 seconds";
              titleText && hint "Please contact an Admin asap, and report to dev that u did not receive your uniform!";
              else (player (((_texture) == (_dfltCopUni)) && !(_swatMember))) then {
                exitWith {};
              };
            };
          };
        };

        case "swatAssignUni" : {
          if player == ((_swatMember) && !(_dfltCop)) then {
            //waitUntil (uniform player == "U_Rangemaster");
            //waitUntil {uniform player != "U_Rangemaster"};
            player forceAddUniform "U_I_CombatUniform"; //U_I_CombatUniform_shortsleeve
            player setObjectTextureGlobal ["textures\swat_uniform.jpg"];
            waitUntil {((_texture) == (_swatUni))};
            sleep 3;
            else ((_texture) != (_swatUni) && uniform player != "U_I_CombatUniform") then {
              systemChat "first log of player not automatically receiving uniform (SWAT)";
              waitUntil {uniform player == "U_I_CombatUniform" && ((_texture) == (_swatUni))};
              sleep 2;
              };
              if (uniform player != (_swatUni) && !(_dfltCop) && == "U_Rangemaster" ) then {
                systemChat "player has not received uniform after 15 seconds";
                titleText && hint "Please contact an Admin asap, and report to dev that u did not receive your uniform!";
                else ((((_texture) == (_swatUni)) && player !(_dfltCop) && ((_texture) !=(_dfltCopUni)) && uniform player != "U_Rangemaster" && uniform player == "U_I_CombatUniform"))) then {
                  exitWith {};
                };
              };
            };
          };
        };
      };
    };
  };
};
};
