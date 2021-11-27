//---------------------------------------------------------------------------------------
//  FILE:   X2StrategyElement_InRFacilitiesUpgrades.uc                                    
//
//	File created by RustyDios & Modified by Losu
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  ADDS Interrogation facility upgrade !!
//
//---------------------------------------------------------------------------------------
class X2StrategyElement_InRFacilitiesUpgrades extends X2StrategyElement_DefaultFacilityUpgrades config(InterrogationAndRecruitment);

var config array<name> strInterrogationFacilityUPGRADE_COST_TYPE;	//225 suplies, 15dust
var config array<int>  iInterrogationFacilityUPGRADE_COST_AMOUNT;	//42 supplies, 1ecore

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Upgrades;

	// rear area, more space, more staff
	Upgrades.AddItem(CreateInterrogationFacility_SecondCell());
	
	return Upgrades;
}

//---------------------------------------------------------------------------------------
// InterrogationFacility Upgrade
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateInterrogationFacility_SecondCell()
{
	local X2FacilityUpgradeTemplate Template;
	local ArtifactCost Resources;
	local int i;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'InterrogationFacility_SecondCell');
	Template.PointsToComplete = 0;
	Template.MaxBuild = 1;
	Template.iPower = class'X2StrategyElement_InRFacilities'.default.InterrogationFacilityPOWER;
	Template.UpkeepCost = class'X2StrategyElement_InRFacilities'.default.InterrogationFacilityUPKEEP;
	Template.strImage = "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_PsionicLab_SecondCell"; //to be replaced";

	Template.OnUpgradeAddedFn = class'X2StrategyElement_DefaultFacilityUpgrades'.static.OnUpgradeAdded_UnlockStaffSlot;
	
	// Costs	Code forloop taken from Iridar, looks for arrays in the config file and cycles through them adding the costs
	for (i = 0; i < default.strInterrogationFacilityUPGRADE_COST_TYPE.Length; i++)
	{
		if (default.iInterrogationFacilityUPGRADE_COST_AMOUNT[i] > 0)
		{
			Resources.ItemTemplateName = default.strInterrogationFacilityUPGRADE_COST_TYPE[i];
			Resources.Quantity = default.iInterrogationFacilityUPGRADE_COST_AMOUNT[i];
			Template.Cost.ResourceCosts.AddItem(Resources);
		}
	}

	return Template;
}
