hbs.registerHelper 'timeline_action', (action) ->

  userPreferedName = hbs.handlebars.helpers.user_preferred_name(action.actor)

  if action.type is "CreateProject"
    verb = "created"

  """<div class="timeline-action">
  <a href="/user/""" + action.actor.username + """"><img src='""" + hbs.handlebars.helpers.gravatar_url(action.actor.email, 60) + """'></a>
  <div class="action">
    <a href="/user/""" + action.actor.username + """">""" + userPreferedName + """</a> 
    """ + verb + """ 
    <a href="/project/Tronic">Tronic</a> 
    """ + hbs.handlebars.helpers.time_ago(this.createdAt) + """
  </div>
  <div class="description"> </div>
  </div>"""