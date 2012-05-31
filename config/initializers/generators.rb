Rails.application.config.generators do |g|
  g.integration_tool :cucumber
  g.stylesheets false
  g.helper false
  g.javascripts false
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
  g.form_builder :simple_form
  g.template_engine :haml
end
