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

var config int AdventTrooperInterrogationDays, AdventStunlancerInterrogationDays, AdventPurifierInterrogationDays, AdventShieldbearerInterrogationDays, AdventCaptainInterrogationDays, AdventPriestInterrogationDays, AdventGeneralInterrogationDays;


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
	Template.PointsToComplete = StafferXDays(1, default.AdventTrooperInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventTrooper";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 1;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventTrooper_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventStunlancerInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventStunlancer";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 2;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventStunlancer_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventPurifierInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventPurifier";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 3;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventPurifier_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventShieldbearerInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventShieldbearer";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 4;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventShieldbearer_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventCaptainInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventCaptain";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 5;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventCaptain_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventPriestInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventPriest";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 6;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventPriest_Rewards';
	
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
	Template.PointsToComplete = StafferXDays(1, default.AdventGeneralInterrogationDays); //8 days = 960 
	Template.strImage = "img:///UILibrary_InR.Tech_Images.TECH_Interrogation_AdventGeneral";
	Template.bProvingGround = true;
	Template.bRepeatable = true;
	Template.SortingTier = 7;

	Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

	Template.Requirements.bVisibleIfItemsNotMet=false;

	// Item Rewards
	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveDeckedItemReward;
	Template.RewardDeck = 'Interrogation_AdventGeneral_Rewards';
	
	Resources.ItemTemplateName = 'InR_Captive_AdventGeneral';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

//*******************************************************************************************
//*******************************************************************************************

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
		return false;
	}

	return true;
}
