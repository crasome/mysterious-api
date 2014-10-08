module AngularTemplateHelper
  def angular_templates(path: Rails.root.join('app', 'views', 'angular'))
    scripts = Dir[File.join(path, '**/_*')].map do |template|
      template = template_name template, path

      content_tag :script, type: 'text/ng-template', id: "#{template}.html" do
        render "angular/#{template}"
      end
    end
    raw scripts.join("\n")
  end

  private
  def template_name(template, path)
    template =~ %r{#{path}/(.+/)?_([^.]+)\.*}
    "#{$1}#{$2}"
  end
end
