require "TimedActions/ISBaseTimedAction"

local old_ISTakePillAction_perform = ISTakePillAction.perform
function ISTakePillAction:perform()
	local result = old_ISTakePillAction_perform(self)
	if self.item:getModule() == 'NeuroTraits' then
		self:useNeuroTraitPills()
		self.item:Use();
	end
	return result
end

function ISTakePillAction:useNeuroTraitPills()
	local type = self.item:getType()
	if type == "PillsRitalarr" then
		ADHDCore.applyMedication()
	end
end