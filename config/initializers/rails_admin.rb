RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'ExpertRequest' do
    edit do
      fields :expert_name, :expert_weight, :methodology
    end
    show do
      field :path
      field :status
      field :methodology
      field :expert_weight
      field :expert_name
    end
    list do
      field :id
      field :path do
        pretty_value do
          "<a href=\"#{value}\" target=\"_blank\">#{value}</a>".html_safe
        end
      end
      field :status
      field :methodology
      field :expert_name
    end
  end
end
