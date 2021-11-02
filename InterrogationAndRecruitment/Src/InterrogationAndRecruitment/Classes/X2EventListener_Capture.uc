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

var config array<name> AdventTrooperCharacterGroups;
var config array<name> AdventTrooperCharacterTemplates;
var config array<name> ExcludedAdventTrooperTemplates;

var config array<name> AdventStunlancerCharacterGroups;
var config array<name> AdventStunlancerCharacterTemplates;
var config array<name> ExcludedAdventStunlancerTemplates;

var config array<name> AdventPurifierCharacterGroups;
var config array<name> AdventPurifierCharacterTemplates;
var config array<name> ExcludedAdventPurifierTemplates;

var config array<name> AdventShieldbearerCharacterGroups;
var config array<name> AdventShieldbearerCharacterTemplates;
var config array<name> ExcludedAdventShieldbearerTemplates;

var config array<name> AdventCaptainCharacterGroups;
var config array<name> AdventCaptainCharacterTemplates;
var config array<name> ExcludedAdventCaptainTemplates;

var config array<name> AdventPriestCharacterGroups;
var config array<name> AdventPriestCharacterTemplates;
var config array<name> ExcludedAdventPriestTemplates;

var config array<name> AdventGeneralCharacterGroups;
var config array<name> AdventGeneralCharacterTemplates;
var config array<name> ExcludedAdventGeneralTemplates;


var config array<name> AndromedonCharacterGroups;
var config array<name> AndromedonCharacterTemplates;
var config array<name> ExcludedAndromedonTemplates;

var config array<name> ArchonCharacterGroups;
var config array<name> ArchonCharacterTemplates;
var config array<name> ExcludedArchonTemplates;

var config array<name> BerserkerCharacterGroups;
var config array<name> BerserkerCharacterTemplates;
var config array<name> ExcludedBerserkerTemplates;

var config array<name> ChryssalidCharacterGroups;
var config array<name> ChryssalidCharacterTemplates;
var config array<name> ExcludedChryssalidTemplates;

var config array<name> FacelessCharacterGroups;
var config array<name> FacelessCharacterTemplates;
var config array<name> ExcludedFacelessTemplates;

var config array<name> MutonCharacterGroups;
var config array<name> MutonCharacterTemplates;
var config array<name> ExcludedMutonTemplates;

var config array<name> SectoidCharacterGroups;
var config array<name> SectoidCharacterTemplates;
var config array<name> ExcludedSectoidTemplates;

var config array<name> ViperCharacterGroups;
var config array<name> ViperCharacterTemplates;
var config array<name> ExcludedViperTemplates;




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
	local name LootName;
	local XComPresentationLayer Presentation;

	Presentation = `PRES;
	History = `XCOMHistory;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	// ADVENT Captives

	if(IsAdventTrooper(CapturedUnit))
	{
        `LOG("Adding ADVENT Trooper Captive");
    	  ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventTrooper');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		    RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventStunlancer(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventStunlancer');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventPurifier(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventPurifier');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventShieldbearer(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventShieldbearer');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventCaptain(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventCaptain');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventPriest(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventPriest');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsAdventGeneral(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventGeneral');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	//Alien Captives

	else if(IsAndromedon(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Andromedon');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsArchon(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Archon');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsBerserker(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Berserker');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsChryssalid(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Chryssalid');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsFaceless(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Faceless');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsMuton(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Muton');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsSectoid(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Sectoid');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	else if(IsViper(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Viper');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	//Remove Timed loot

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

static public function bool IsAdventTrooper(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventTrooperTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventTrooperCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventTrooperCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventStunlancer(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventStunlancerTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventStunlancerCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventStunlancerCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventPurifier(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventPurifierTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventPurifierCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventPurifierCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventShieldbearer(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventShieldbearerTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventShieldbearerCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventShieldbearerCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventCaptain(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventCaptainTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventCaptainCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventCaptainCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventPriest(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventPriestTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventPriestCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventPriestCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsAdventGeneral(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAdventGeneralTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AdventGeneralCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AdventGeneralCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}


static public function bool IsAndromedon(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedAndromedonTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.AndromedonCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.AndromedonCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsArchon(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedArchonTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.ArchonCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.ArchonCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsBerserker(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedBerserkerTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.BerserkerCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.BerserkerCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsChryssalid(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedChryssalidTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.ChryssalidCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.ChryssalidCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsFaceless(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedFacelessTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.FacelessCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.FacelessCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsMuton(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedMutonTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.MutonCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.MutonCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsSectoid(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedSectoidTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.SectoidCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.SectoidCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}

static public function bool IsViper(XComGameState_Unit CapturedUnit)
{
  if (CapturedUnit != none)
  {
    if (default.ExcludedViperTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE)
    {
      return false;
    }
    else if (default.ViperCharacterTemplates.Find(CapturedUnit.GetMyTemplateName()) != INDEX_NONE
            || default.ViperCharacterGroups.Find(CapturedUnit.GetMyTemplateGroupName()) != INDEX_NONE)
    {
      return true;
    }
  }
  return false;
}