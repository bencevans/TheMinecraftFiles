hbs.registerHelper "project_widget", (project) ->
  projectImage = project.image.src or "/assets/img/DefaultProjectWidget.png"
  [" <div class=\"projectwidget\" onclick=\"location.href='/project/" + project.name + "';\" style=\"background-image:url('" + projectImage + "');\">", "<div class=\"info\">", "\t<h3>" + project.name + "</h3><p>Created By: <a href=\"/user/" + project.creator.username + "\">" + project.creator.username + "</a>.</p>", "</div>", "</div>"].join ""

