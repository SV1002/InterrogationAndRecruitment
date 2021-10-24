//---------------------------------------------------------------------------------------
//  FILE:   X2Item_InR.uc                                    
//
//	File created by Losu
//
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Adds Captured unit templates for this mod's functions
//
//---------------------------------------------------------------------------------------

class X2Item_InR_Rewards extends X2Item config (InterrogationAndRecruitment);

//create the templates
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;
	
	Resources.AddItem(CreateInterrogation_AdventTrooper_Intel());
	Resources.AddItem(CreateInterrogation_AdventTrooper_FacilityLead());
	
	return Resources;
}

//*******************************************************************************************
//                                 ADVENT CAPTIVES
//*******************************************************************************************

static function X2DataTemplate CreateInterrogation_AdventTrooper_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventTrooper_Intel');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Interrogation_Images.AdventTrooper_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventTrooper_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventTrooper_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Interrogation_Images.AdventTrooper_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}