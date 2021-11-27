//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Removes Timed loot off of captives, so it isn't duplicated... That is all folks...
//
//*******************************************************************************************
class XComGameState_Unit_RemoveLoot extends XComGameState_Unit;

static function RemoveAllLoot(XComGameState_Unit Unit)
{
	Unit.PendingLoot.LootToBeCreated.Length = 0;
}