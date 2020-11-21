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

  config.model 'Methodology' do
    weight 1
    navigation_label 'Base'

    edit do
      fields :name
    end
  end

  config.model 'Parameter' do
    weight 2
    navigation_label 'Base'

    edit do
      fields :name, :default_weight
    end

    list do
      fields :id, :name, :default_weight
    end
  end

  config.model 'ParameterValue' do
    weight 3
    navigation_label 'Base'
    label 'Possible values'

    edit do
      fields :parameter, :value, :default_weight
    end

    list do
      fields :id, :parameter, :value, :default_weight
    end
  end

  config.model 'ExpertRequest' do
    weight 4
    navigation_label 'Expert'

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

  config.model 'ParameterMethodologyExpertScore' do
    weight 5
    navigation_label 'Expert'

    edit do
      fields :parameter_value, :methodology, :expert_request, :status, :score, :expert_weight
    end

    list do
      fields :id, :methodology, :parameter_value, :score, :expert_weight
    end
  end

  config.model 'ParameterMethodologyTotalScore' do
    weight 6
    navigation_label 'Expert'

    edit do
      fields :parameter_value, :methodology, :score
    end

    list do
      fields :id, :methodology, :parameter_value, :parameter, :score
    end
  end

  ##############################################################################

  config.model 'User' do
    weight 7
    navigation_label 'Users'

    edit do
      fields :username, :role
      field :password do
        visible do
          bindings[:object].new_record?
        end
      end
    end

    list do
      fields :id, :username, :role, :created_at
    end
  end

  config.model 'Project' do
    weight 8
    navigation_label 'Users'

    edit do
      fields :name, :user
    end

    list do
      fields :id, :name, :user, :status
    end
  end

  config.model 'ProjectParameterValue' do
    weight 9
    navigation_label 'Users'

    edit do
      fields :project, :parameter, :parameter_value, :status
    end
  end

  config.model 'ParametersComparison' do
    weight 10
    navigation_label 'Users'

    edit do
      fields :project, :parameter_a, :parameter_b, :value, :inversed, :status
    end
    list do
      fields :id, :parameter_a, :parameter_b, :value, :inversed, :status
    end
  end

end
