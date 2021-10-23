//---------------------------------------------------------------------------------------
//  FILE:   X2StrategyElement_InRStaffSlots.uc                                    
//
//	File created by RustyDios & Modified by Losu
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Adds Interrogation Facility staff slots !!
//
//---------------------------------------------------------------------------------------
class X2StrategyElement_InRStaffSlots extends X2StrategyElement_DefaultStaffSlots;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> StaffSlots;

	StaffSlots.AddItem(CreateInterrogationFacilityEngineerStaffSlotTemplate());
	return StaffSlots;
}

//#############################################################################################
//----------------   ENGINEER 'from PG'  ------------------------------------------------------
//#############################################################################################

static function X2DataTemplate CreateInterrogationFacilityEngineerStaffSlotTemplate()
{
	local X2StaffSlotTemplate Template;

	Template = CreateStaffSlotTemplate('InterrogationFacilityStaffSlot_Eng');
	Template.bEngineerSlot = true;
	Template.FillFn = FillInterrogationFacilitySlot;
	Template.EmptyFn = EmptyInterrogationFacilitySlot;
	Template.ShouldDisplayToDoWarningFn = ShouldDisplayInterrogationFacilityToDoWarning;
	Template.GetAvengerBonusAmountFn = GetInterrogationFacilityAvengerBonus;
	Template.GetBonusDisplayStringFn = GetInterrogationFacilityBonusDisplayString;
	Template.MatineeSlotName = "Engineer";

	return Template;
}

//#############################################################################################
//	BOTH ENGI'S AND SCI'S BEHAVE THE SAME
//	PROGRESS ADDED TO 'PSI TRAINING RATE' WHICH IS USED AS BUILD TIME FOR PEX M PROJECTS
//#############################################################################################

static function FillInterrogationFacilitySlot(XComGameState NewGameState, StateObjectReference SlotRef, StaffUnitInfo UnitInfo, optional bool bTemporary = false)
{
	local XComGameState_Unit NewUnitState;
	local XComGameState_StaffSlot NewSlotState;

	FillSlot(NewGameState, SlotRef, UnitInfo, NewSlotState, NewUnitState);
}

static function EmptyInterrogationFacilitySlot(XComGameState NewGameState, StateObjectReference SlotRef)
{
	local XComGameState_StaffSlot NewSlotState;
	local XComGameState_Unit NewUnitState;

	EmptySlot(NewGameState, SlotRef, NewSlotState, NewUnitState);
}

static function bool ShouldDisplayInterrogationFacilityToDoWarning(StateObjectReference SlotRef)
{
	local XComGameState_StaffSlot SlotState;
	SlotState = XComGameState_StaffSlot(`XCOMHISTORY.GetGameStateForObjectID(SlotRef.ObjectID));

	if (SlotState.GetFacility().BuildQueue.Length > 0)
	{
		return true;
	}
	
	return false;
}

static function int GetInterrogationFacilityAvengerBonus(XComGameState_Unit Unit, optional bool bPreview)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local float PercentIncrease;
	local int NewWorkPerHour;

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	// Need to return the percent increase in overall project speed provided by this unit
	NewWorkPerHour = GetContributionDefault(Unit) + XComHQ.XComHeadquarters_DefaultProvingGroundWorkPerHour;
	PercentIncrease = (GetContributionDefault(Unit) * 100.0) / NewWorkPerHour;

	return Round(PercentIncrease);
}

static function string GetInterrogationFacilityBonusDisplayString(XComGameState_StaffSlot SlotState, optional bool bPreview)
{
	local string Contribution;

	if (SlotState.IsSlotFilled())
	{
		Contribution = string(GetInterrogationFacilityAvengerBonus(SlotState.GetAssignedStaff(), bPreview));
	}

	return GetBonusDisplayString(SlotState, "%AVENGERBONUS", Contribution);
}
