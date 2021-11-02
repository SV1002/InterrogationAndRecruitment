//*******************************************************************************************
//  FILE:   Event Listeners                      
//  
//	File created by Losu
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Event listeners for capturing units   
//
//*******************************************************************************************
class X2EventListener_Capture extends X2EventListener config (InterrogationAndRecruitment);

struct CaptureRewardStruct
{
  var array<name> CharacterGroups;
  var array<name> CharacterTemplates;
  var array<name> ExcludedCharacterTemplates;
  var name CaptiveItem;
};

var config array<CaptureRewardStruct> arrCaptureReward;

var localized string CapturedTitle;
var localized string Captured;

var localized string LootTitle;
var localized string Loot;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AddFultonedCapturedUnit());
	Templates.AddItem(AddEndOfMissionCapture());

	return Templates;
}

static function CHEventListenerTemplate AddFultonedCapturedUnit()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'FultonCaptureEvent');
	Template.RegisterInTactical = true;
	Template.AddCHEvent('UnitRemovedFromPlay', WasCaptured);

	return Template;
}

static function CHEventListenerTemplate AddEndOfMissionCapture()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'EndOfMissionCaptureEvent');
	Template.RegisterInTactical = true;
	Template.AddCHEvent('TacticalGameEnd', EndOfTacticalCapture, ELD_OnStateSubmitted);

	return Template;
}

static protected function EventListenerReturn WasCaptured(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Unit KilledUnit;
	local XComGameState_BattleData BattleData;
	local XComPresentationLayer Presentation;
	local XGParamTag kTag;
	local XComGameState NewGameState;
	local X2ItemTemplate ItemTemplate;
	local StateObjectReference AbilityRef;

	KilledUnit = XComGameState_Unit(EventSource);
	BattleData = XComGameState_BattleData( `XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_BattleData' ) );
	// bad data somewhere
	if ((BattleData == none) || (KilledUnit == none))
		return ELR_NoInterrupt;

	AbilityRef = KilledUnit.FindAbility('Evac');

	if(AbilityRef.ObjectID > 0)
		return ELR_NoInterrupt;

	// ignore everybody that leaves the field that isn't advent or an alien
	if (KilledUnit.IsSoldier() || (!KilledUnit.IsAdvent() && !KilledUnit.IsAlien()) )
		return ELR_NoInterrupt;


	if(!KilledUnit.IsDead() && KilledUnit.bBodyRecovered) //successful capture or extraction by XCOM of a hostile unit
	{

		Presentation = `PRES;
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Hybrid Unit");
		GiveLootToXCOM(NewGameState, KilledUnit, ItemTemplate);
		`GAMERULES.SubmitGameState(NewGameState);

		kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
		kTag.StrValue0 = ItemTemplate.GetItemFriendlyName();

		Presentation.NotifyBanner(default.CapturedTitle, "img:///UILibrary_XPACK_Common.WorldMessage", KilledUnit.GetName(eNameType_Full), `XEXPAND.ExpandString(default.Captured),  eUIState_Good);

		`SOUNDMGR.PlayPersistentSoundEvent("UI_Blade_Positive");


	}

	return ELR_NoInterrupt;
}

static protected function EventListenerReturn EndOfTacticalCapture(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState, OriginalUnitState;
	local XComGameState_BattleData BattleData;
	local XComGameState NewGameState;
	local X2ItemTemplate ItemTemplate;

	History = `XCOMHISTORY;
  
  `LOG("Checking for captives to collect");
  
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));

  if (BattleData.AllTacticalObjectivesCompleted())
  {
    foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
    {
      OriginalUnitState = XComGameState_Unit(History.GetOriginalGameStateRevision(UnitState.ObjectID));
      if (!UnitState.IsInPlay() || UnitState.IsDead()) continue;
      if (OriginalUnitState.IsFriendlyToLocalPlayer()) continue;
      if (!UnitState.IsMindControlled() && !UnitState.IsBleedingOut() && !UnitState.IsUnconscious()) continue;

      `LOG("Running Capture Event on:" @ UnitState.GetFullName());

      NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Hybrid Unit");
      GiveLootToXCOM(NewGameState, UnitState, ItemTemplate);
      `GAMERULES.SubmitGameState(NewGameState);
    }
  }
	return ELR_NoInterrupt;
}

static function GiveLootToXCOM(XComGameState NewGameState, XComGameState_Unit CapturedUnit, out X2ItemTemplate RefItemTemplate)
{
    local XComGameStateHistory History; 
    local XComGameState_HeadquartersXCom XComHQ;
    local X2ItemTemplateManager ItemMgr;
    local X2ItemTemplate ItemTemplate;
    local XComGameState_Item ItemState, LootItem;
    local CaptureRewardStruct CaptureReward;  
    local CaptureRewardStruct FoundCaptureReward;  
	  local name LootName;
	  local XComPresentationLayer Presentation;
 
	Presentation = `PRES;
    History = `XCOMHistory;
    XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));    
    ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
    
    foreach default.arrCaptureReward(CaptureReward)
    {
        // Excluded character template - not interested.
        if (CaptureReward.CharacterGroups.Find(CapturedUnit.GetMyTemplate().CharacterGroupName) != INDEX_NONE)
        {
            if (CaptureReward.ExcludedCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE) continue;
            FoundCaptureReward = CaptureReward;            
            break;
        }

        // Captured unit is part of configured character templates
        if (CaptureReward.CharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
        {            
            FoundCaptureReward = CaptureReward;
            break;
        }  
    }    
 
    if (FoundCaptureReward.CaptiveItem == '') return; // Couldn't get a reward item. Should probably do a redscreen
 
    ItemTemplate = ItemMgr.FindItemTemplate(FoundCaptureReward.CaptiveItem); // Get template
    ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState); // Generate item state     
    RefItemTemplate = ItemTemplate; // For our out parameter
    XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID)); // MSO XCOM HQ
    XComHQ.PutItemInInventory(NewGameState, ItemState); // Put item into inventory

	if(CapturedUnit.HasLoot()) //we have normal loot. Since this isn't recovered by extract corpses, we do it ourselves.
	{
		foreach CapturedUnit.PendingLoot.LootToBeCreated(LootName)
		{	
			ItemTemplate = ItemMgr.FindItemTemplate(LootName);
			if (ItemTemplate != none)
			{
				if (CapturedUnit.bKilledByExplosion && !ItemTemplate.LeavesExplosiveRemains) //this shouldn't even proc, but just in case....
					continue;                                                                               //  item leaves nothing behind due to explosive death
				if (CapturedUnit.bKilledByExplosion && ItemTemplate.ExplosiveRemains != '')
					ItemTemplate = ItemMgr.FindItemTemplate(ItemTemplate.ExplosiveRemains);     //  item leaves a different item behind due to explosive death
			
				if (ItemTemplate != none)
				{
				
					LootItem = ItemTemplate.CreateInstanceFromTemplate(NewGameState);

					LootItem.OwnerStateObject = XComHQ.GetReference();
					XComHQ.PutItemInInventory(NewGameState, LootItem, true);
	
				}
			}
			class'XComGameState_Unit_RemoveLoot'.static.RemoveAllLoot(CapturedUnit); // so this doesn't get duplicated
		}


			Presentation.NotifyBanner(default.LootTitle, "img:///UILibrary_XPACK_Common.WorldMessage", CapturedUnit.GetName(eNameType_Full), default.Loot,  eUIState_Good);

			`SOUNDMGR.PlayPersistentSoundEvent("UI_Blade_Positive");
	}
}
