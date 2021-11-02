//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  ADDS Alien Interrogations
// 		a tech needs bProvingGround + "Tech_InR" as the prefix of the template name to show up in the Interrogation Facility
//		or added to the 'bypass' list for UIChoosePexMProject .. InterrogationAndRecruitment configs
//		the new techs here won't show up in the proving ground list due to the SpecialRequirementsFn :)
//
//*******************************************************************************************
class X2StrategyElement_Interrogation_Alien extends X2StrategyElement_XpackTechs config (InterrogationAndRecruitment);

var config int AndromedonInterrogationDays, AndromedonMinIntel, AndromedonMaxIntel, AndromedonFacilityLeadChance;

var config int ArchonInterrogationDays, ArchonMinIntel, ArchonMaxIntel, ArchonFacilityLeadChance;

var config int BerserkerInterrogationDays, BerserkerMinIntel, BerserkerMaxIntel, BerserkerFacilityLeadChance;

var config int ChryssalidInterrogationDays, ChryssalidMinIntel, ChryssalidMaxIntel, ChryssalidFacilityLeadChance;

var config int FacelessInterrogationDays, FacelessMinIntel, FacelessMaxIntel, FacelessFacilityLeadChance;

var config int MutonInterrogationDays, MutonMinIntel, MutonMaxIntel, MutonFacilityLeadChance;

var config int SectoidInterrogationDays, SectoidMinIntel, SectoidMaxIntel, SectoidFacilityLeadChance;

var config int ViperInterrogationDays, ViperMinIntel, ViperMaxIntel, ViperFacilityLeadChance;

var config bool AndromedonGivesCorpse, ArchonGivesCorpse, BerserkerGivesCorpse, ChryssalidGivesCorpse, FacelessGivesCorpse, MutonGivesCorpse, SectoidGivesCorpse, ViperGivesCorpse;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

		Techs.AddItem(CreateTech_InR_Interrogation_Andromedon());
		Techs.AddItem(CreateTech_InR_Interrogation_Archon());
		Techs.AddItem(CreateTech_InR_Interrogation_Berserker());
		Techs.AddItem(CreateTech_InR_Interrogation_Chryssalid());
		Techs.AddItem(CreateTech_InR_Interrogation_Faceless());
		Techs.AddItem(CreateTech_InR_Interrogation_Muton());
		Techs.AddItem(CreateTech_InR_Interrogation_Sectoid());
		Techs.AddItem(CreateTech_InR_Interrogation_Viper());

	return Techs;
}


//*******************************************************************************************
//                                   Alien Interrogations
//*******************************************************************************************

static function X2DataTemplate CreateTech_InR_Interrogation_Andromedon()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Andromedon');
	Template.PointsToComplete = StafferXDays(1, default.AndromedonInterrogationDays); //14 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Andromedon";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 1;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Andromedon');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Andromedon';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Archon()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Archon');
	Template.PointsToComplete = StafferXDays(1, default.ArchonInterrogationDays); //14 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Archon";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 2;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Archon');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Archon';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Berserker()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Berserker');
	Template.PointsToComplete = StafferXDays(1, default.BerserkerInterrogationDays); //10 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Berserker";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 3;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Berserker');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Berserker';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Chryssalid()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Chryssalid');
	Template.PointsToComplete = StafferXDays(1, default.ChryssalidInterrogationDays); //6 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Chryssalid";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 4;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Chryssalid');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Chryssalid';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Faceless()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Faceless');
	Template.PointsToComplete = StafferXDays(1, default.FacelessInterrogationDays); //8 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Faceless";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 5;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Faceless');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Faceless';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Muton()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Muton');
	Template.PointsToComplete = StafferXDays(1, default.MutonInterrogationDays); //11 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Muton";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 6;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Muton');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Muton';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Sectoid()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Sectoid');
	Template.PointsToComplete = StafferXDays(1, default.SectoidInterrogationDays); //7 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Sectoid";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 7;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Sectoid');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Sectoid';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Viper()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Viper');
	Template.PointsToComplete = StafferXDays(1, default.ViperInterrogationDays); //7 days
	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Viper";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 8;

	Template.Requirements.RequiredItems.AddItem('InR_Captive_Viper');
	Template.Requirements.bVisibleIfItemsNotMet=false;
	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	// Item Rewards
	Template.ResearchCompletedFn = InterrogationTechCompleted;
	
	Resources.ItemTemplateName = 'InR_Captive_Viper';
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

	if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Andromedon')
	{
		IntelAmount = default.AndromedonMinIntel + `SYNC_RAND_STATIC(default.AndromedonMaxIntel - default.AndromedonMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAndromedon');

		if (default.AndromedonGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.AndromedonFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Andromedon_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Andromedon_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Archon')
	{
		IntelAmount = default.ArchonMinIntel + `SYNC_RAND_STATIC(default.ArchonMaxIntel - default.ArchonMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseArchon');

		if (default.ArchonGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.ArchonFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Archon_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}
		
		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Archon_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Berserker')
	{
		IntelAmount = default.BerserkerMinIntel + `SYNC_RAND_STATIC(default.BerserkerMaxIntel - default.BerserkerMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseBerserker');

		if (default.BerserkerGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.BerserkerFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Berserker_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Berserker_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Chryssalid')
	{
		IntelAmount = default.ChryssalidMinIntel + `SYNC_RAND_STATIC(default.ChryssalidMaxIntel - default.ChryssalidMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseChryssalid');

		if (default.ChryssalidGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.ChryssalidFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Chryssalid_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Chryssalid_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Faceless')
	{
		IntelAmount = default.FacelessMinIntel + `SYNC_RAND_STATIC(default.FacelessMaxIntel - default.FacelessMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseFaceless');

		if (default.FacelessGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.FacelessFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Faceless_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Faceless_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Muton')
	{
		IntelAmount = default.MutonMinIntel + `SYNC_RAND_STATIC(default.MutonMaxIntel - default.MutonMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseMuton');

		if (default.MutonGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.MutonFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Muton_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Muton_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Sectoid')
	{
		IntelAmount = default.SectoidMinIntel + `SYNC_RAND_STATIC(default.SectoidMaxIntel - default.SectoidMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseSectoid');

		if (default.SectoidGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.SectoidFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Sectoid_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Sectoid_Intel');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
		}
	}

	else if(TechState.GetMyTemplateName() == 'Tech_InR_Interrogation_Viper')
	{
		IntelAmount = default.ViperMinIntel + `SYNC_RAND_STATIC(default.ViperMaxIntel - default.ViperMinIntel + 1);
		CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseViper');

		if (default.ViperGivesCorpse)
		{
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
		}

		if (FacilityLeadRoll < default.ViperFacilityLeadChance)
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Viper_FacilityLead');
			GiveInterrogationItemReward(NewGameState, TechState, ItemTemplate);
			class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
		}

		else
		{
			ItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Viper_Intel');
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