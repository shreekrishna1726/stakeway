module ApplicationHelper
	def uuid_without_child
		Profile.all_needy_parent.first
	end
end
