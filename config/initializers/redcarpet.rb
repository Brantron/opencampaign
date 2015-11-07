class ActionView::Template
  class MarkdownTemplateHandler
    def self.erb
      @erb ||= ActionView::Template.registered_template_handler(:erb)
    end

    def self.call(template)
      source = erb.call(template)
      <<-SOURCE
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true
      }
      Redcarpet::Markdown.new(renderer, options).render(begin;#{source};end)
      SOURCE
    end
  end

  register_template_handler(:md, MarkdownTemplateHandler)
end
