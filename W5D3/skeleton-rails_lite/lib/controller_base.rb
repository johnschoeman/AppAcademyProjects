require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'Double render error: ' if self.already_built_response?
    @res.location = url
    @res.status = 302
    @session.store_session(@res)
    @already_built_response = true
    @res
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'Double render error: ' if self.already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @session.store_session(@res)
    @already_built_response = true
    @res
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = "views/#{self.class.to_s.underscore}/#{template_name.to_s}.html.erb"
    template = File.read(path)
    p template
    erb_template = ERB.new(template)
    content = erb_template.result(binding)
    content_type = 'text/html'
    self.render_content(content, content_type)
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    unless self.already_built_response?
      render(name)
    end
  end
end
