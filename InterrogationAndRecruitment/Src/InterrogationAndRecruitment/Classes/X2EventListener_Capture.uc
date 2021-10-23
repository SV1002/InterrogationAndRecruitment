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

	return Templates;
}

static function X2EventListenerTemplate AddFultonedCapturedUnit()
{
	local X2EventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'FultonCaptureEvent');
	Template.RegisterInTactical = true;
	Template.AddEvent('UnitRemovedFromPlay', WasCaptured);

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


	if(KilledUnit.IsAlive() && KilledUnit.bBodyRecovered) //successful capture or extraction by XCOM of a hostile unit
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
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventTrooper');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventStunlancer(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventStunlancer');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventPurifier(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventPurifier');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventShieldbearer(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventShieldbearer');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventCaptain(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventCaptain');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventPriest(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventPriest');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsAdventGeneral(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_AdventGeneral');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	//Alien Captives

	if(IsAndromedon(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Andromedon');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsArchon(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Archon');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsBerserker(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Berserker');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsChryssalid(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Chryssalid');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsFaceless(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Faceless');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsMuton(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Muton');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsSectoid(CapturedUnit))
	{
    	ItemTemplate = ItemMgr.FindItemTemplate('InR_Captive_Sectoid');
        ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		RefItemTemplate = ItemTemplate;

        XComHQ.PutItemInInventory(NewGameState, ItemState);
	}

	if(IsViper(CapturedUnit))
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

static public function bool IsAdventTrooper(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventTrooperCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventTrooperCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventTrooperTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventStunlancer(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventStunlancerCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventStunlancerCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventStunlancerTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventPurifier(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventPurifierCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventPurifierCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventPurifierTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventShieldbearer(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventShieldbearerCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventShieldbearerCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventShieldbearerTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventCaptain(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventCaptainCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventCaptainCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventCaptainTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventPriest(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventPriestCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventPriestCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventPriestTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsAdventGeneral(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AdventGeneralCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AdventGeneralCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAdventGeneralTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}


static public function bool IsAndromedon(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.AndromedonCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.AndromedonCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedAndromedonTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsArchon(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.ArchonCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.ArchonCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedArchonTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsBerserker(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.BerserkerCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.BerserkerCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedBerserkerTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsChryssalid(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.ChryssalidCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.ChryssalidCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedChryssalidTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsFaceless(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.FacelessCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.FacelessCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedFacelessTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsMuton(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.MutonCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.MutonCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedMutonTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsSectoid(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.SectoidCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.SectoidCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedSectoidTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}

static public function bool IsViper(XComGameState_Unit UnitState)
{
	return UnitState != none && 
		  ( default.ViperCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE || default.ViperCharacterGroups.Find(UnitState.GetMyTemplateGroupName()) != INDEX_NONE) &&
           default.ExcludedViperTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
}