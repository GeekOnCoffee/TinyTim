Rails.application.config.generators do |g|
  g.test_framework nil # Using minitest, but don't want generators.
  g.integration_tool :cucumber
  g.stylesheets false
  g.helper false
  g.javascripts false
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
  g.template_engine :haml
end
