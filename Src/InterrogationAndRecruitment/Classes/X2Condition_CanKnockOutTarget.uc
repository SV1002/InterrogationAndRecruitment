class X2Condition_CanKnockOutTarget extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
	{
		return 'AA_NotAUnit';
	}

	if (TargetUnit.IsStunned() || TargetUnit.IsPanicked() || TargetUnit.IsMindControlled())
	{
		return 'AA_Success';
	}
	
	return 'AA_AbilityUnavailable';
}