//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                            
//  
//	File created by RustyDios & Modified by Losu
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Interrogation Facility Staff Slot,	LEBs No More dropdowns incorporated 
//
//*******************************************************************************************
class UIFacility_InterrogationFacilitySlot extends UIFacility_StaffSlot dependson(UIPersonnel);

var localized string m_strInRProjectDialogTitle;
var localized string m_strInRProjectDialogText;
var localized string m_strStopInRProjectDialogTitle;
var localized string m_strStopInRProjectDialogText;

simulated function UIStaffSlot InitStaffSlot(UIStaffContainer OwningContainer, StateObjectReference LocationRef, int SlotIndex, delegate<OnStaffUpdated> onStaffUpdatedDel)
{
	super.InitStaffSlot(OwningContainer, LocationRef, SlotIndex, onStaffUpdatedDel);
	
	return self;
}

simulated function ShowDropDown()
{
	local XComGameState_StaffSlot StaffSlot;

	StaffSlot = XComGameState_StaffSlot(`XCOMHISTORY.GetGameStateForObjectID(StaffSlotRef.ObjectID));

	//hide the original list if not locked
	if(!StaffSlot.IsLocked())
	{
		StaffContainer.HideDropDown(self);
	}

	//if slot is locked jump to upgrades
	if (StaffSlot.IsLocked())
	{
		ShowUpgradeFacility();
	}
	//if unlocked and empty open new drop down lists
    else if (StaffSlot.IsSlotEmpty())
    {
        //StaffContainer.ShowDropDown(self);
        OnInRProjectSelected();
    }
}

//no special treatment necessary since LW2 doesnt have special psilab slots
simulated function QueueDropDownDisplay()
{
	ShowDropDown();
}

simulated function OnInRProjectSelected()
{
	if(IsDisabled)
	{
		return;
	}

	ShowSoldierList(eUIAction_Accept, none);
}

simulated function ShowSoldierList(eUIAction eAction, UICallbackData xUserData)
{
	local UIPersonnel_InR kPersonnelList;
	local XComHQPresentationLayer HQPres;
	local XComGameState_StaffSlot StaffSlotState;
	
	if (eAction == eUIAction_Accept)
	{
		HQPres = `HQPRES;
		StaffSlotState = XComGameState_StaffSlot(`XCOMHISTORY.GetGameStateForObjectID(StaffSlotRef.ObjectID));

		//Don't allow clicking of Personnel List is active or if staffslot is filled
		if(HQPres.ScreenStack.IsNotInStack(class'UIPersonnel_InR') && !StaffSlotState.IsSlotFilled())
		{
			kPersonnelList = Spawn( class'UIPersonnel_InR', HQPres);
			kPersonnelList.m_eListType = eUIPersonnel_Soldiers;
			kPersonnelList.onSelectedDelegate = OnSoldierSelected;
			kPersonnelList.m_bRemoveWhenUnitSelected = true;
			kPersonnelList.SlotRef = StaffSlotRef;
			HQPres.ScreenStack.Push( kPersonnelList );
		}
	}
}

simulated function OnSoldierSelected(StateObjectReference _UnitRef)
{
	local XComGameState_Unit Unit;

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(_UnitRef.ObjectID));

	InRPromoteDialog(Unit);
}

simulated function InRPromoteDialog(XComGameState_Unit Unit)
{
	local XGParamTag LocTag;
	local TDialogueBoxData DialogData;
	local XComGameState_HeadquartersXCom XComHQ;
	local int TrainingRateModifier;
	local UICallbackData_StateObjectReference CallbackData;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	TrainingRateModifier = XComHQ.PsiTrainingRate / XComHQ.XComHeadquarters_DefaultPsiTrainingWorkPerHour;

	LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	LocTag.StrValue0 = Unit.GetName(eNameType_RankFull);
	LocTag.IntValue0 = (XComHQ.GetPsiTrainingDays() / TrainingRateModifier);

	CallbackData = new class'UICallbackData_StateObjectReference';
	CallbackData.ObjectRef = Unit.GetReference();
	DialogData.xUserData = CallbackData;
	DialogData.fnCallbackEx = InRPromoteDialogCallback;

	DialogData.eType = eDialog_Alert;
	DialogData.strTitle = m_strInRProjectDialogTitle;
	DialogData.strText = `XEXPAND.ExpandString(m_strInRProjectDialogText);
	DialogData.strAccept = class'UIUtilities_Text'.default.m_strGenericYes;
	DialogData.strCancel = class'UIUtilities_Text'.default.m_strGenericNo;

	Movie.Pres.UIRaiseDialog(DialogData);
}

simulated function InRPromoteDialogCallback(Name eAction, UICallbackData xUserData)
{	
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_StaffSlot StaffSlot;
	local XComGameState_FacilityXCom FacilityState;
	local UICallbackData_StateObjectReference CallbackData;
	local StaffUnitInfo UnitInfo;

	CallbackData = UICallbackData_StateObjectReference(xUserData);

	if(eAction == 'eUIAction_Accept')
	{		
		StaffSlot = XComGameState_StaffSlot(`XCOMHISTORY.GetGameStateForObjectID(StaffSlotRef.ObjectID));
		
		if (StaffSlot != none)
		{
			UnitInfo.UnitRef = CallbackData.ObjectRef;
			StaffSlot.FillSlot(UnitInfo); // The Training project is started when the staff slot is filled
            //the training project IS: XComGameState_HeadquartersProjectInRProject
			
			`XSTRATEGYSOUNDMGR.PlaySoundEvent("StrategyUI_Staff_Assign");
			
			XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
			FacilityState = StaffSlot.GetFacility();
			if (FacilityState.GetNumEmptyStaffSlots() > 0)
			{
				StaffSlot = FacilityState.GetStaffSlot(FacilityState.GetEmptyStaffSlotIndex());

				if ((StaffSlot.IsScientistSlot() && XComHQ.GetNumberOfUnstaffedScientists() > 0) ||
					(StaffSlot.IsEngineerSlot() && XComHQ.GetNumberOfUnstaffedEngineers() > 0))
				{
					`HQPRES.UIStaffSlotOpen(FacilityState.GetReference(), StaffSlot.GetMyTemplate());
				}
			}
		}

		UpdateData();	//goes deep into UIStaffSlot via UIFacility_StaffSlot to set the slotstate
		//Update(StaffSlotState.GetNameDisplayString(),		Caps(StaffSlotState.GetBonusDisplayString()),		StaffSlotState.GetUnitTypeImage());
	}
}

//==============================================================================

defaultproperties
{
	width = 370;
	height = 65;
}
