ActiveAdmin.register News do
	menu :parent => 'User'

  filter :id
  filter :username
  filter :email


  actions :index, :show, :new, :create, :update, :edit

  scope :admin do
    User.joins(:roles).where("roles.id = #{Role.find_by_name("admin").id}")
  end
end
