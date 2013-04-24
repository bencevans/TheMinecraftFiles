hbs.registerHelper 'timeline_action', (action) ->

  userPreferedName = hbs.handlebars.helpers.user_preferred_name(action.actor)

  project = if action.project then action.project.name else "deleted"

  if action.type is "CreateProject"
    verb = "created"
  else if action.type is "GalleryUpload"
    verb = "uploaded an <a href=\"/project/#{project}/gallery/#{action.data}\">image</a> to"
  else
    verb = action.type


  """<div class="timeline-action">
  <a href="/user/""" + action.actor.username + """"><img src='""" + hbs.handlebars.helpers.gravatar_url(action.actor.email, 60) + """'></a>
  <div class="action">
    <a href="/user/""" + action.actor.username + """">""" + userPreferedName + """</a> 
    """ + verb + """ 
    <a href="/project/#{project}">#{project}</a> 
    """ + hbs.handlebars.helpers.time_ago(this.createdAt) + """
  </div>
  <div class="description"> </div>
  </div>"""