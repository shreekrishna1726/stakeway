class Profile < ApplicationRecord
		
	has_ancestry cache_depth: true

	# acts_as_nested_set
	belongs_to :user, class_name: 'Spree::User', foreign_key: :user_id
	has_one :charge
	after_create :generate_uuid
	after_create :update_tree_set

	belongs_to :parent, class_name: "Profile", foreign_key: :parent_id
	has_many :children, class_name: "Profile", foreign_key: :parent_id
	validates_presence_of :referral_id
	validates_uniqueness_of :uuid

	def generate_uuid
		self.uuid = SecureRandom.hex(5)
		self.save
	end


	def full_name
		first_name + last_name	
	end


	def self.all_needy_parent
		level = CurrentLevel.first.level
		profiles = Profile.where(tree_level: level)
		need_profiles = []
		profiles.all.each do |profile|
			if profile.children.count < 5
				need_profiles << profile
			else
				profile.children.each do |child|
					if child.children.count < 5
						need_profiles << child
					end
				end
			end
		end
		return need_profiles
	end

	@@tree = {}
	def ppppp
		subtree.each do |e|
		  pid = e[:parent_id]
		  if pid == nil || !map.has_key?(pid)
		    (@@tree[root] ||= []) << e
		  else
		    (@@tree[map[pid]] ||= []) << e
		  end
		end
		
		p "---------------"


		p @@tree

	end

	def comp_level
		if children.count >= 2
			p ""
			children.each do |child|
				if child.children.count > 1
					child.comp_level
				end
			end 
		end
	end


	def all_children(children_array = [])
	    children_array += self.children
	    children.each do |child|
	        return child.all_children(children_array)
	    end
	    return children_array
	end



	def update_parent_referral_amount(profile)
		if profile.parent == nil
		else
			parent_profile = profile.parent
			if parent_profile.children.count == 5
					parent_profile.user.update_and_create_store_credits
					update_parent_referral_amount(parent_profile)
			end
		end
	end

	$gvar = 0 
	def nested_profile(profile)
		if profile.children?
		  profile.children.each do |child|
		    nested_profile(child)
		  end
		end 
	end

	def last_depth
		level = []
    if child_ids.empty?
    	p depth
      return depth
    else
      return children.map{|c| c.last_depth}.max
    end
  end


  def pooooo
	  count = subtree.collect(&:depth).uniq.count

  end

	def self.all_needy_parent_nodes
		curren_level = CurrentLevel.last.level
		if curren_level == 1
			leaf_should_be = 5
		else
			leaf_should_be = 5 ** CurrentLevel.last.level
		end
		actual_leaf_nodes = Profile.where(tree_level: curren_level ).count
		if actual_leaf_nodes  == leaf_should_be
			CurrentLevel.last.update_attributes(level: curren_level + 1)
		end
	end

	def update_tree_set
		curren_level = CurrentLevel.last.level
		leaf_should_be = 5 ** CurrentLevel.last.level
		actual_leaf_nodes = Profile.where(tree_level: curren_level ).count
		if actual_leaf_nodes  == leaf_should_be
			CurrentLevel.last.update_attributes(level: curren_level + 1)
		end
		# if self.level != 1
		# current_profile_nodes = Profile.where(level: self.level - 1).count
		# nodes_should_be = (self - 2 )* 5
		# if self.level == 1
		# 	CurrentLevel.destroy_all
		# 	CurrentLevel.new(level: self.level).save
		# elsif current_profile_nodes == nodes_should_be
		# 	#update level table
		# 	CurrentLevel.destroy_all
		# 	CurrentLevel.new(level: self.level).save		
		# end
	end


	def complete_children?
		if self.children.count == 5
			return true
		else
			return false
		end
	end


	def user_email
		user.email
	end

	def to_param
		"#{id}-#{first_name.parameterize}"
	end


	
end
