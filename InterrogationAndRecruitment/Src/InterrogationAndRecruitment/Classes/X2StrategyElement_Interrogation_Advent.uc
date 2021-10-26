//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  ADDS ADVENT Interrogations
// 		a tech needs bProvingGround + "Tech_InR" as the prefix of the template name to show up in the Interrogation Facility
//		or added to the 'bypass' list for UIChoosePexMProject .. InterrogationAndRecruitment configs
//		the new techs here won't show up in the proving ground list due to the SpecialRequirementsFn :)
//
//*******************************************************************************************
class X2StrategyElement_Interrogation_Advent extends X2StrategyElement_XpackTechs config (InterrogationAndRecruitment);

var config int AdventTrooperInterrogationDays, AdventTrooperMinIntel, AdventTrooperMaxIntel, AdventTrooperFacilityLeadChance;

var config int AdventStunlancerInterrogationDays, AdventStunlancerMinIntel, AdventStunlancerMaxIntel, AdventStunlancerFacilityLeadChance;

var config int AdventPurifierInterrogationDays, AdventPurifierMinIntel, AdventPurifierMaxIntel, AdventPurifierFacilityLeadChance;

var config int AdventShieldbearerInterrogationDays, AdventShieldbearerMinIntel, AdventShieldbearerMaxIntel, AdventShieldbearerFacilityLeadChance;

var config int AdventCaptainInterrogationDays, AdventCaptainMinIntel, AdventCaptainMaxIntel, AdventCaptainFacilityLeadChance;

var config int AdventPriestInterrogationDays, AdventPriestMinIntel, AdventPriestMaxIntel, AdventPriestFacilityLeadChance;

var config int AdventGeneralInterrogationDays, AdventGeneralMinIntel, AdventGeneralMaxIntel, AdventGeneralFacilityLeadChance;

var config bool AdventTrooperGivesCorpse, AdventStunlancerGivesCorpse, AdventPurifierGivesCorpse, AdventShieldbearerGivesCorpse, AdventCaptainGivesCorpse, AdventPriestGivesCorpse, AdventGeneralGivesCorpse;



var config bool bSkipPGExclusion;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

		Techs.AddItem(CreateTech_InR_Interrogation_AdventTrooper());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventStunlancer());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventPurifier());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventShieldbearer());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventCaptain());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventPriest());
		Techs.AddItem(CreateTech_InR_Interrogation_AdventGeneral());

	return Techs;
}


//*******************************************************************************************
//                                   ADVENT Interrogations
//*******************************************************************************************

static function X2DataTemplate CreateTech_InR_Interrogation_AdventTrooper()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventTrooper');
	Template.PointsToComplete = StafferXDays(1, default.AdventTrooperInterrogationDays); //5 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventTrooper";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 1;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventTrooper');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	
	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventTrooper';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventStunlancer()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventStunlancer');
	Template.PointsToComplete = StafferXDays(1, default.AdventStunlancerInterrogationDays); //7 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventStunlancer";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 2;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventStunlancer');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventStunlancer';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventPurifier()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventPurifier');
	Template.PointsToComplete = StafferXDays(1, default.AdventPurifierInterrogationDays); //8 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPurifier";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 3;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventPurifier');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventPurifier';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventShieldbearer()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventShieldbearer');
	Template.PointsToComplete = StafferXDays(1, default.AdventShieldbearerInterrogationDays); //10 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventShieldbearer";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 4;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventShieldbearer');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventShieldbearer';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventCaptain()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventCaptain');
	Template.PointsToComplete = StafferXDays(1, default.AdventCaptainInterrogationDays); //12 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventCaptain";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 5;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventCaptain');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventCaptain';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventPriest()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventPriest');
	Template.PointsToComplete = StafferXDays(1, default.AdventPriestInterrogationDays); //14 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPriest";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 6;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventPriest');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventPriest';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_AdventGeneral()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_AdventGeneral');
	Template.PointsToComplete = StafferXDays(1, default.AdventGeneralInterrogationDays); //15 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventGeneral";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 7;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_AdventGeneral');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_AdventGeneral';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

//*******************************************************************************************
//*******************************************************************************************

static function InterrogationTechCompleted(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate, FacilityLeadItemTemplate, CorpseItemTemplate;	
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local int IntelAmount, FacilityLeadRoll;

	History = `XCOMHISTORY;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if(XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	}
	
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	FacilityLeadItemTemplate = ItemTemplateManager.FindItemTemplate('FacilityLeadItem');
	FacilityLeadRoll = `SYNC_RAND_STATIC(100);

	if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventTrooper')
	{
		IntelAmount = default.AdventTrooperMinIntel + `SYNC_RAND_STATIC(default.AdventTrooperMaxIntel - default.AdventTrooperMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventTrooper');

		if (default.AdventTrooperGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventTrooperFacilityLeadChance)
        {
            ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventTrooper_FacilityLead');
            GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
            class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
        }

        else
        {
            ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventTrooper_Intel');
            GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
        }
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventStunlancer')
	{
		IntelAmount = default.AdventStunlancerMinIntel + `SYNC_RAND_STATIC(default.AdventStunlancerMaxIntel - default.AdventStunlancerMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventStunLancer');

		if (default.AdventStunlancerGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventStunlancerFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventStunlancer_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventStunlancer_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventPurifier')
	{
		IntelAmount = default.AdventPurifierMinIntel + `SYNC_RAND_STATIC(default.AdventPurifierMaxIntel - default.AdventPurifierMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventPurifier');

		if (default.AdventPurifierGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventPurifierFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPurifier_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPurifier_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventShieldbearer')
	{
		IntelAmount = default.AdventShieldbearerMinIntel + `SYNC_RAND_STATIC(default.AdventShieldbearerMaxIntel - default.AdventShieldbearerMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventShieldbearer');

		if (default.AdventShieldbearerGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventShieldbearerFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventShieldbearer_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventShieldbearer_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventCaptain')
	{
		IntelAmount = default.AdventCaptainMinIntel + `SYNC_RAND_STATIC(default.AdventCaptainMaxIntel - default.AdventCaptainMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventOfficer');

		if (default.AdventCaptainGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventCaptainFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventCaptain_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventCaptain_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventPriest')
	{
		IntelAmount = default.AdventPriestMinIntel + `SYNC_RAND_STATIC(default.AdventPriestMaxIntel - default.AdventPriestMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventPriest');

		if (default.AdventPriestGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventPriestFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPriest_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPriest_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_AdventGeneral')
	{
		IntelAmount = default.AdventGeneralMinIntel + `SYNC_RAND_STATIC(default.AdventGeneralMaxIntel - default.AdventGeneralMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventOfficer');

		if (default.AdventGeneralGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AdventGeneralFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventGeneral_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventGeneral_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}
	
	TechState.IntelReward = IntelAmount;
	XComHQ.AddResource(NewGameState, 'Intel', IntelAmount);
}

private static function GiveInterrogationItemReward(XComGameState NewGameState, XComGameState_Tech TechState, X2ItemTemplate ItemTemplate)
{	
	class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, ItemTemplate);

	TechState.ItemRewards.Length = 0; // Reset the item rewards array in case the tech is repeatable
	TechState.ItemRewards.AddItem(ItemTemplate); // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = false; // Reset the research report for techs that are repeatable
}


//helper func			
//Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;
static function bool AreWeInTheInterrogationFacility()
{
	if(default.bSkipPGExclusion)
	{
		return true;
	}

	//if the screen is not in the stack, assume we're not in the pexm facility buy menu
	if (`HQPRES.ScreenStack.IsNotInStack(class'UIChooseInRProject'))
	{
		return true;
	}

	return true;
}