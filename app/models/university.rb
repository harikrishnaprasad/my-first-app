class University < ActiveRecord::Base
validates :name_of_the_university,:address,:presence=>true
validates :name_of_the_university,:address,:length=>{:maximum => 100}
validates :name_of_the_university,:address,:uniqueness =>true
def self.search(search)
if search
where('name LIKE ? or description LIKE ? ',"%#{search}%","%#{search}%")
else
scoped
end
end
end
