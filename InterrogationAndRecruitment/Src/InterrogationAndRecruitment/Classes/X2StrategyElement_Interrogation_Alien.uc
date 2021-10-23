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

var config int AndromedonInterrogationDays, ArchonInterrogationDays, BerserkerInterrogationDays, ChryssalidInterrogationDays, FacelessInterrogationDays, MutonInterrogationDays, SectoidInterrogationDays, ViperInterrogationDays;

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

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Andromedon');
	Template.PointsToComplete = StafferXDays(1, default.AndromedonInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Andromedon";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 1;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Andromedon_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Andromedon';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Archon()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Archon');
	Template.PointsToComplete = StafferXDays(1, default.ArchonInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Archon";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 2;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Archon_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Archon';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Berserker()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Berserker');
	Template.PointsToComplete = StafferXDays(1, default.BerserkerInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Berserker";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 3;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Berserker_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Berserker';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Chryssalid()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Chryssalid');
	Template.PointsToComplete = StafferXDays(1, default.ChryssalidInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Chryssalid";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 4;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Chryssalid_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Chryssalid';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Faceless()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Faceless');
	Template.PointsToComplete = StafferXDays(1, default.FacelessInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Faceless";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 5;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Faceless_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Faceless';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Muton()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Muton');
	Template.PointsToComplete = StafferXDays(1, default.MutonInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Muton";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 6;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Muton_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Muton';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Sectoid()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Sectoid');
	Template.PointsToComplete = StafferXDays(1, default.SectoidInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Sectoid";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 7;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Sectoid_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Sectoid';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTech_InR_Interrogation_Viper()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_InR_Interrogation_Viper');
	Template.PointsToComplete = StafferXDays(1, default.ViperInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_Viper";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 8;

	Template.Requirements.SpecialRequirementsFn = class'X2StrategyElement_Interrogation_Advent'.static.AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_Viper_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_Viper';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}