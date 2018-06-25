require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase

  test "resolver returns a template with the saved body" do
    resolver = SqlTemplate::Resolver.new()
    details = { formats: [:html], locale: [:en], handlers: [:erb] }

    assert resolver.find_all("index", "posts", false, details ).empty?
    SqlTemplate.create!(
                   body: "<%= 'Hi form SqlTemplate' %>",
                   path: "posts/index",
                   format: "html",
                   locale: "en",
                   handler: "erb",
                   partial: false
                   )
    # Assertion about template can be found
    template = resolver.find_all("index","posts",false,details).first
    assert_kind_of ActionView::Template, template

    #Assertion about specific information about the template
    assert_equal "<%= 'Hi form SqlTemplate' %>", template.source
    assert_kind_of ActionView::Template::Handlers::ERB, template.handler
    assert_equal [:html], template.formats
    assert_equal "posts/index", template.virtual_path
    assert_match %r[SqlTemplate - \d+ - "posts/index"], template.identifier
  end
  #
  # test "sql_template expires the cache on update" do
  #   cache_key = Object.new
  #   resolver = SqlTemplate::Resolver.instance
  #   details = { formats: [html], locale: [:en], handlers: [:erb] }
  #   t = resolver.find_all("index", "users", false, details, cache_key).first
  #   assert_match"Listing users", t.source
  #
  #   sql_template = sql_templates(:users_index)
  #   sql_template.update_attributes(body: "New body for template")
  #
  #   assert_equal "New body for template", t.source
  #
  # end

end
