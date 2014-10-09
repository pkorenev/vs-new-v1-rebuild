#require 'rails_admin/i18n_support'
#require "#{Gem.loaded_specs['rails_admin'].full_gem_path}/app/helpers/rails_admin/application_helper"



module RailsAdmin
  module ApplicationHelperPatch
    #include RailsAdmin::I18nSupport

    def self.included(receiver)
      #receiver.send :include, InstanceMethods

      receiver.class_eval do
        def render_custom_fields_rows(issue)
          "It works".html_safe
        end
      end
    end

    def navigation_tree
      root = RailsAdmin::Config.navigation_static_links

      content_tag :ul, class: 'nav nav-list' do
        root.each do | item |
          #content_tag :li, link_to
          if item.parent
            if item.content && item.content.is_a?(Hash) && item.content[:link]
              if item.content[:new_tab] && item.content[:new_tab] == true
                concat( content_tag(:li, link_to("#{ item.content[:title] ? item.content[:title] : item.name }", item.content[:link], class: "#{ item.level > 2 ? 'nav-level-'+ (item.level - 2).to_s : '' }", target: '_blank'  ) ) )
              else
                concat( content_tag(:li, link_to("#{ item.content[:title] ? item.content[:title] : item.name }", item.content[:link], class: "#{ item.level > 2 ? 'nav-level-'+ (item.level - 2).to_s : '' }"  ) ) )
              end
            else
              concat( content_tag( :li, "#{ item.content && item.content[:title] ? item.content[:title] : item.name }",class: 'nav-header' ) )
            end
          end
        end
      end
    end

    #def navigation_tree
    #  #content_tag :ul do
    #    #RailsAdmin::Config.navigation_static_tree.co
    #  #end
    #
    #  ul = content_tag :ul
    #
    #  array = [
    #      {
    #          title: 'SEO',
    #          children: [
    #              {
    #                  title: 'title'
    #              }
    #          ]
    #      }
    #  ]
    #
    #  items = {lucky_luke: '#', jolly_jumper: '#', rin_tin_tin: '#', group: { joe: '#', william: '#', jack: '#', averell: '#'} }
    #
    #
    #  content_tag :ul, class: 'nav nav-list' do
    #    iterate_items(items) do |c|
    #      concat( content_tag(:li, c) )
    #    end
    #  end


      #ul = content_tag :ul do
      #  iterate_tree(array) do |value|
      #    #ul.html_attributes.add("attr-#{ul.html_attributes.count}")
      #    content_tag :li, value.to_s
      #  end
      #end

      #return ul

      #render inline: ''
    #end

    #def iterate_items(node)
    #  cast.each do |node|
    #    if character.is_a?(Array)
    #
    #      iterate_items(character) { | key, value, role | yield( key, value, role ) }
    #      #define_method :role do
    #
    #      #end
    #
    #    elsif node.is_a?(Hash)
    #      iterate_items(character) { | key, value, role | yield( key, value, role ) }
    #    else
    #      yield(key, value, role)
    #    end
    #  end
    #end

    #def iterate_tree(node, &block)
    #  if node.kind_of?(Hash)
    #    node.each do | item |
    #      yield( iterate_tree(item, &block) )
    #    end
    #
    #  elsif node.kind_of?(Array)
    #    node.each do | item |
    #      yield( iterate_tree(item, &block) )
    #    end
    #  else
    #    yield( node )
    #  end
    #
    #  #yield( iterate_tree(node.children(), &block))
    #end



  end
end
