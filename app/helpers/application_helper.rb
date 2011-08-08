module ApplicationHelper
  def semantic_pluralize(count, singular, plural = nil)
    content_tag(:span, "#{count || 0} ", :class => 'count') +
      ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
  end

  def twitter_link(screen_name)
    url = "https://twitter.com/#{screen_name}"
    link_to "@#{screen_name}", url
  end

  # Generates a link to sort the collection by the given column
  #
  # Options:
  #   - :label => The text of the link, defaults to the humanized version of the column name
  #   - :default_order => Direction to use when first sorting by this column, either :asc or :desc
  #   - :is_default =>  Specifies that the given column has been set as the default on the model, 
  #                     in order to properly assign the 'current' class on initial page load with
  #                     no params given. Can be set to :asc or :desc to match the direction specified
  #                     in the model.
  #
  def sort_link(column, options = {})
    # Options
    options = { :label => column.to_s.humanize.titleize,
                :default_order => :asc }.merge(options)

    if options[:is_default] && params[:column].nil? && params[:order].nil?
      is_current = true
      current_order = options[:is_default]
    else
      is_current = params[:column].eql?(column.to_s)
      current_order = params[:order]
    end

    # Add params and build new query string
    query = params.merge({
      :column => column,
      :order => is_current ? (current_order.to_s.eql?('asc') ? 'desc' : 'asc') : options[:default_order]
    })

    class_name = is_current ? "current #{query[:order]}" : options[:default_order]
    link_to(options[:label], query, :class => "#{column} #{class_name}")
  end

  # Return a URL for the given +string+.
  def normalize_url(string)
    return Addressable::URI.heuristic_parse(string).to_s
  end

  def provider_name(provider)
    OmniAuth::Utils.camelize(provider)
  end

  def render_flash
    unless flash.blank?
      content_tag("div", :id => "flash", :class => "flash") do
        flash.keys.sort{|a,b| a.to_s <=> b.to_s }.map do |key|
          render_message(key, flash[key])
        end.join("\n").html_safe
      end
    end
  end

  def render_message(type, content, label = true)
    type = :notice if type.to_sym == :alert
    classes = ['message', type, (label ? 'with_label' : nil)]
    title = flash_type_title(type)
    content_tag("div", :class => classes.compact.join(' ')) do
      (label ? content_tag(:span, title, :class => 'message_type') : '') << content_tag(:div, content, :class => 'message_content')
    end
  end

  def flash_type_title(type)
    flowery_vocabulary = {
      :error   => [ 'Egads', 'Balderdash', 'Fiddlesticks', 'Holy Toledo', 'Tarnation', 'Damnation', 'Fooey',
                    'Boo', 'Aw shucks', 'Uh oh', 'Great Scott', "Blisterin' barnacles", "Duoh" ],
      :success => [ 'Yippee', 'Hooray', 'Awesome', 'Yeehaw', 'Hoorah', 'Huzzah', 'Yeah', 'Yay', 'So Rad', 'BooYah' ],
      :notice  => [ 'Heads up', 'Avast', 'Notice', 'Yo' ],
      :warning => [ 'Beware', 'Warning', 'Watch out' ]
    }

    if flowery_vocabulary[type]
      return "#{flowery_vocabulary[type].sample}!"
    else
      return type.to_s.titleize
    end
  end
  
  def activity_image(item)
    case item.class.to_s
    when "Comment"
      image_tag(item.user.person.photo.url)
    when "Team"
    when "Milestone"
    when "TeamMember"
    else
    end    
  end
  
  def activity_type(item)
    case item.class.to_s
    when "Comment"
      if item.commentable_type == "DeployTask"
        raw("Comment posted on #{link_to item.commentable.name, "#{item.team.to_url}/guide/#{item.commentable.class.to_s.downcase}/#{item.commentable.id}"}")
      elsif item.commentable_type == "Team"
        raw("Comment posted on #{link_to "Team: #{item.commentable.name.gsub('-', ' ').titlecase}", "#{item.commentable.to_url}"}")
      end
    when "Team"
      "From Geek Robot"
    when "DeployTask"
      "From Geek Robot"
    when "TeamMember"
      "From Geek Robot"
    else
    end
  end
  
  def goal_name(item)
    case item
    when 1
      "Goal 1: Setup the Server"
    when 2
      "Goal 2: Get Data"
    when 3
      "Goal 3: Customize the Design"      
    when 4
      "Goal 4: Build Community Support"            
    when 5  
      "Goal 5: Launch It!"            
    end  
  end
  
  def goal_select_list
    select "milestone", "goal", [["Goal 1: Setup the Server",1], ["Goal 2: Get Data",2], ["Goal 3: Customize the Design",3],["Goal 4: Build Community Support",4], ["Goal 5: Launch It!",5]]
  end
  
end
