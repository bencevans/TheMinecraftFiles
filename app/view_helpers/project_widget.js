hbs.registerHelper('project_widget', function(project) {

	projectImage = '/assets/img/DefaultProjectWidget.png';
	return [' <div class="projectwidget" onclick="location.href=\'/project/' + project.name + '\';" style="background-image:url(\'' + projectImage + '\');">',
	'<div class="info">',
	'	<h3>' + project.name + '</h3><p>Created By: <a href="user/' + project.creator.username + '">' + project.creator.username + '</a>.</p>',
	'</div>',
	'</div>'].join('');

});