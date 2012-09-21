class College < ActiveRecord::Base
validates :college_Name, :code, :address, :establish_Year, :presence=>true
validates :college_Name, :code, :address, :establish_Year,:length => { :minimum => 2 }
validates :college_Name,:address,:length => { :maximum => 100 }
validates :college_Name,:address,:uniqueness =>true
def self.search(search)
if search
where('college_Name LIKE ? or code LIKE ? address LIKE ? establish_Year',"%#{search}%",
"%#{search}%","%#{search}%","%#{search}%")
else
scoped
end
end
end
